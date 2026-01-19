// DONE: Create MarketData model class
// Required fields:
// - symbol (String)
// - price (double)
// - change24h (double)
// - changePercent24h (double)
// - volume (double)
//
// Add a factory constructor fromJson that parses the JSON response
// Example JSON structure from API:
// {
//   "symbol": "BTC/USD",
//   "price": 43250.50,
//   "change24h": 2.5,
//   "changePercent24h": 2.5,
//   "volume": 1250000000
// }

class MarketData {
  const MarketData({
    required this.symbol,
    required this.price,
    required this.change24h,
    required this.changePercent24h,
    required this.volume,
    this.marketCap,
    this.high24h,
    this.low24h,
    this.lastUpdated,
    this.description,
  });

  final String symbol;
  final double price;
  final double change24h;
  final double changePercent24h;
  final double volume;
  final double? marketCap;
  final double? high24h;
  final double? low24h;
  final DateTime? lastUpdated;
  final String? description;

  factory MarketData.fromJson(Map<String, dynamic> json) {
    return MarketData(
      symbol: json['symbol']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      change24h: (json['change24h'] as num?)?.toDouble() ?? 0,
      changePercent24h: (json['changePercent24h'] as num?)?.toDouble() ?? 0,
      volume: (json['volume'] as num?)?.toDouble() ?? 0,
      marketCap: (json['marketCap'] as num?)?.toDouble(),
      high24h: (json['high24h'] as num?)?.toDouble(),
      low24h: (json['low24h'] as num?)?.toDouble(),
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.tryParse(json['lastUpdated'].toString())
          : null,
      description: json['description']?.toString(),
    );
  }

  MarketData copyWith({
    String? symbol,
    double? price,
    double? change24h,
    double? changePercent24h,
    double? volume,
    double? marketCap,
    double? high24h,
    double? low24h,
    DateTime? lastUpdated,
    String? description,
  }) {
    return MarketData(
      symbol: symbol ?? this.symbol,
      price: price ?? this.price,
      change24h: change24h ?? this.change24h,
      changePercent24h: changePercent24h ?? this.changePercent24h,
      volume: volume ?? this.volume,
      marketCap: marketCap ?? this.marketCap,
      high24h: high24h ?? this.high24h,
      low24h: low24h ?? this.low24h,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'price': price,
      'change24h': change24h,
      'changePercent24h': changePercent24h,
      'volume': volume,
      'marketCap': marketCap,
      'high24h': high24h,
      'low24h': low24h,
      'lastUpdated': lastUpdated?.toIso8601String(),
      'description': description,
    };
  }
}
