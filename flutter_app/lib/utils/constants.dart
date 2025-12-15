// App-wide constants
class AppConstants {
  // API Configuration
  // Note: For Android emulator, use 10.0.2.2 instead of localhost
  // For iOS simulator, localhost works fine
  static const String baseUrl = 'http://localhost:3000/api';
  static const String wsUrl = 'ws://localhost:3000';
  
  // For Android emulator, uncomment these:
  // static const String baseUrl = 'http://10.0.2.2:3000/api';
  // static const String wsUrl = 'ws://10.0.2.2:3000';
  
  // API Endpoints
  static const String marketDataEndpoint = '/market-data';
  static const String analyticsEndpoint = '/analytics';
  static const String portfolioEndpoint = '/portfolio';
  
  // Timeframes
  static const List<String> timeframes = ['1h', '4h', '1d', '7d', '30d'];
  
  // Colors
  static const int positiveColor = 0xFF4CAF50; // Green
  static const int negativeColor = 0xFFF44336; // Red
}
