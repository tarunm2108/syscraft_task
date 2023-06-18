import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static final ApiClient instance = ApiClient._internal();

  factory ApiClient() {
    return instance;
  }

  ApiClient._internal();

  static const String baseUrl = '';

  Future<http.Response> getMethod({
    required String url,
    Map<String, String>? header,
  }) async {
    final uri = Uri.parse(url);
    debugPrint('Request url: ${uri.toString()}');
    final response = await http.get(uri);
    debugPrint('Response body: ${response.body}');
    return response;
  }

}
