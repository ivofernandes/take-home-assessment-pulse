import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/market_data_model.dart';

class MarketDataCache {
  static const _cacheKey = 'market_data_cache';

  Future<void> save(List<MarketData> data) async {
    final prefs = await SharedPreferences.getInstance();
    final payload = data.map((item) => item.toJson()).toList();
    await prefs.setString(_cacheKey, json.encode(payload));
  }

  Future<List<MarketData>> read() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_cacheKey);
    if (raw == null || raw.isEmpty) {
      return [];
    }
    final decoded = json.decode(raw);
    if (decoded is! List) {
      return [];
    }
    return decoded
        .whereType<Map<String, dynamic>>()
        .map(MarketData.fromJson)
        .toList();
  }
}
