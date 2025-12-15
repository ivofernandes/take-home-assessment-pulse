import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ApiService {
  static const String baseUrl = AppConstants.baseUrl;
  
  // TODO: Implement getMarketData() method
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
    // TODO: Implement this method
    throw UnimplementedError('getMarketData() not implemented');
  }
}
