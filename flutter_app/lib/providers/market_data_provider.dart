import 'dart:async';
import 'package:flutter/foundation.dart';
import '../services/api_errors.dart';
import '../services/api_service.dart';
import '../services/analytics_service.dart';
import '../services/market_data_cache.dart';
import '../services/websocket_service.dart';
import '../models/market_data_model.dart';
import '../utils/app_config.dart';

class MarketDataProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final MarketDataCache _cache = MarketDataCache();
  final WebSocketService _webSocketService = WebSocketService();

  bool _isWebSocketConnected = false;
  bool _initialized = false;
  Timer? _reconnectTimer;

  List<MarketData> _marketData = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';
  SortOption _sortOption = SortOption.symbol;
  bool _sortAscending = true;
  
  List<MarketData> get marketData => _marketData;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isWebSocketConnected => _isWebSocketConnected;
  String get searchQuery => _searchQuery;
  SortOption get sortOption => _sortOption;
  bool get sortAscending => _sortAscending;

  List<MarketData> get filteredMarketData {
    final normalizedQuery = _searchQuery.trim().toLowerCase();
    final filtered = normalizedQuery.isEmpty
        ? List<MarketData>.from(_marketData)
        : _marketData
            .where(
              (item) => item.symbol.toLowerCase().contains(normalizedQuery),
            )
            .toList();
    filtered.sort((a, b) {
      int comparison;
      switch (_sortOption) {
        case SortOption.price:
          comparison = a.price.compareTo(b.price);
          break;
        case SortOption.changePercent24h:
          comparison = a.changePercent24h.compareTo(b.changePercent24h);
          break;
        case SortOption.symbol:
          comparison = a.symbol.compareTo(b.symbol);
          break;
      }
      return _sortAscending ? comparison : -comparison;
    });
    return filtered;
  }
  
  void initialize() {
    if (_initialized) {
      return;
    }
    _initialized = true;
    connectWebSocket();
  }

  void updateSearchQuery(String query) {
    final trimmed = query.trim();
    _searchQuery = trimmed.length > 20 ? trimmed.substring(0, 20) : trimmed;
    AnalyticsService.logEvent(
      'search_market',
      parameters: {'query': _searchQuery},
    );
    notifyListeners();
  }

  void updateSortOption(SortOption option) {
    _sortOption = option;
    AnalyticsService.logEvent(
      'sort_market',
      parameters: {'option': option.name},
    );
    notifyListeners();
  }

  void toggleSortOrder() {
    _sortAscending = !_sortAscending;
    AnalyticsService.logEvent(
      'toggle_sort_order',
      parameters: {'ascending': _sortAscending},
    );
    notifyListeners();
  }

  // DONE: Implement loadMarketData() method
  // This should:
  // 1. Set _isLoading = true and _error = null
  // 2. Call notifyListeners()
  // 3. Call _apiService.getMarketData()
  // 4. Convert the response to List<MarketData> using MarketData.fromJson
  // 5. Set _marketData with the result
  // 6. Handle errors by setting _error
  // 7. Set _isLoading = false
  // 8. Call notifyListeners() again
  
  Future<void> loadMarketData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final delaySeconds = AppConfig.loadDelaySeconds;
      if (delaySeconds > 0) {
        await Future.delayed(Duration(seconds: delaySeconds));
      }
      final data = await _apiService.getMarketData();
      _marketData = data.map((json) => MarketData.fromJson(json)).toList();
      await _cache.save(_marketData);
      AnalyticsService.logEvent(
        'load_market_success',
        parameters: {'count': _marketData.length},
      );
    } catch (e) {
      await _recoverFromError(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void connectWebSocket() {
    _reconnectTimer?.cancel();
    _webSocketService.connect();
    _webSocketService.connectionStream?.listen((connected) {
      _isWebSocketConnected = connected;
      if (!connected) {
        _scheduleReconnect();
      }
      notifyListeners();
    });
    _webSocketService.stream?.listen(_handleWebSocketMessage);
  }

  void _handleWebSocketMessage(dynamic message) {
    if (message is Map<String, dynamic> &&
        message['type'] == 'market_update' &&
        message['data'] is Map) {
      _isWebSocketConnected = true;
      _applyMarketUpdate(
        Map<String, dynamic>.from(message['data'] as Map),
      );
    }
  }

  Future<void> _recoverFromError(Object error) async {
    if (error is ApiException) {
      _error = error.message;
    } else {
      _error = error.toString();
    }
    // Attempt to surface cached data for offline support.
    final cached = await _cache.read();
    if (cached.isNotEmpty) {
      _marketData = cached;
      AnalyticsService.logEvent('load_market_cache_fallback');
      _error = '${_error ?? 'Failed to load data.'} Showing cached data.';
    } else {
      AnalyticsService.logEvent(
        'load_market_failed',
        parameters: {'error': _error ?? 'unknown'},
      );
    }
  }

  void _scheduleReconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 5), () {
      connectWebSocket();
    });
  }

  void _applyMarketUpdate(Map<String, dynamic> data) {
    final symbol = data['symbol']?.toString();
    if (symbol == null) {
      return;
    }
    final price = _toDouble(data['price']);
    final change24h = _toDouble(data['change24h']);
    final volume = _toDouble(data['volume']);
    final lastUpdated = data['timestamp'] != null
        ? DateTime.tryParse(data['timestamp'].toString())
        : null;
    final index = _marketData.indexWhere((item) => item.symbol == symbol);
    if (index == -1) {
      return;
    }
    final current = _marketData[index];
    _marketData[index] = current.copyWith(
      price: price ?? current.price,
      change24h: change24h ?? current.change24h,
      volume: volume ?? current.volume,
      lastUpdated: lastUpdated ?? current.lastUpdated,
    );
    notifyListeners();
  }

  double? _toDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }

  @override
  void dispose() {
    _reconnectTimer?.cancel();
    _webSocketService.disconnect();
    super.dispose();
  }
}

enum SortOption {
  symbol,
  price,
  changePercent24h,
}
