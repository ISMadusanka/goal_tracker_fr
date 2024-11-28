import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  // Singleton instance
  static final ApiService _instance = ApiService._internal();

  // Private constructor
  ApiService._internal();

  // Factory constructor to return the same instance
  factory ApiService() {
    return _instance;
  }

  // Secure storage instance
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Base URL for the API
  final String _baseUrl = 'https://goal-tracker-be.vercel.app';

  // Method to get the JWT token from secure storage
  Future<String?> _getToken() async {
    return await _storage.read(key: 'jwtToken');
  }

  // Method to add headers with the JWT token
  Future<Map<String, String>> _getHeaders() async {
    final token = await _getToken();
    print("token"+token.toString());
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Example of a GET request
  Future<http.Response> get(String endpoint) async {
    final headers = await _getHeaders();
    final url = Uri.parse('$_baseUrl$endpoint');
    final response = await http.get(url, headers: headers);
    return response;
  }

  // Example of a POST request
  Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    final url = Uri.parse('$_baseUrl$endpoint');
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
    return response;
  }

  // Example of a PUT request
  Future<http.Response> put(String endpoint, Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    final url = Uri.parse('$_baseUrl$endpoint');
    final response = await http.put(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
    return response;
  }

  // Example of a DELETE request
  Future<http.Response> delete(String endpoint) async {
    final headers = await _getHeaders();
    final url = Uri.parse('$_baseUrl$endpoint');
    final response = await http.delete(url, headers: headers);
    return response;
  }

  // Method to store the JWT token
  Future<void> setToken(String token) async {
    await _storage.write(key: 'jwtToken', value: token);
  }

  // Method to clear the JWT token
  Future<void> clearToken() async {
    await _storage.delete(key: 'jwtToken');
  }
}
