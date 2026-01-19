import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import 'api_errors.dart';

class ApiService {
  static const String baseUrl = AppConstants.baseUrl;
  
  // DONE: Implement getMarketData() method
  // This should call GET /api/market-data and return the response
  // Example:
  // Future<List<Map<String, dynamic>>> getMarketData() async {
  //   final response = await http.get(Uri.parse('$baseUrl/market-data'));
  //   if (response.statusCode == 200) {
  //     final jsonData = json.decode(response.body);
  //     return List<Map<String, dynamic>>.from(jsonData['data']);
  //   } else {
  //     throw Exception('Failed to load market data: ${response.statusCode}');
  //   }
  // }
  
  Future<List<Map<String, dynamic>>> getMarketData() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${AppConstants.marketDataEndpoint}'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is! Map<String, dynamic>) {
          throw ParsingException('Unexpected response shape.');
        }
        final data = jsonData['data'];
        if (data is List) {
          return List<Map<String, dynamic>>.from(data);
        }
        throw ParsingException('Unexpected response format.');
      } else {
        throw ServerException(
          'Failed to load market data: ${response.statusCode}',
        );
      }
    } on SocketException {
      throw NetworkException(
        'No connection to the server. Please check your internet connection.',
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('Failed to load market data: $e');
    }
  }
}
