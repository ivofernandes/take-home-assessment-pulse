import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../models/market_data_model.dart';

class MarketDataProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  List<MarketData> _marketData = [];
  bool _isLoading = false;
  String? _error;
  
  List<MarketData> get marketData => _marketData;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  // TODO: Implement loadMarketData() method
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
      // TODO: Implement API call and data conversion
      // final data = await _apiService.getMarketData();
      // _marketData = data.map((json) => MarketData.fromJson(json)).toList();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
