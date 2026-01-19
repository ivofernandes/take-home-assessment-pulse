import 'package:flutter_test/flutter_test.dart';
import 'package:pulsenow_flutter/models/market_data_model.dart';
import 'package:pulsenow_flutter/services/market_data_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('MarketData.fromJson parses required fields', () {
    final data = MarketData.fromJson({
      'symbol': 'BTC/USD',
      'price': 100.5,
      'change24h': 1.2,
      'changePercent24h': 1.5,
      'volume': 2000,
      'marketCap': 50000,
    });

    expect(data.symbol, 'BTC/USD');
    expect(data.price, 100.5);
    expect(data.change24h, 1.2);
    expect(data.changePercent24h, 1.5);
    expect(data.volume, 2000);
    expect(data.marketCap, 50000);
  });

  test('MarketDataCache reads and writes cached data', () async {
    SharedPreferences.setMockInitialValues({});
    final cache = MarketDataCache();
    final items = [
      MarketData(
        symbol: 'ETH/USD',
        price: 2000,
        change24h: -10,
        changePercent24h: -0.5,
        volume: 100,
      ),
    ];

    await cache.save(items);
    final loaded = await cache.read();

    expect(loaded.length, 1);
    expect(loaded.first.symbol, 'ETH/USD');
  });
}
