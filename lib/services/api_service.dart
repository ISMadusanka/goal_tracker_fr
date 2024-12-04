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
  //final String _baseUrl = 'http://localhost:5000';


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
    print("data"+data.toString());

    try {
      final headers = await _getHeaders();
      final url = Uri.parse('$_baseUrl$endpoint');
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(data),
      );
      print("response"+response.toString());
      return response;
    } catch (e) {
      print("error"+e.toString());
      return http.Response("error", 500);
    }
    // final headers = await _getHeaders();
    // final url = Uri.parse('$_baseUrl$endpoint');
    // final response = await http.post(
    //   url,
    //   headers: headers,
    //   body: jsonEncode(data),
    // );
    // print("response"+response.toString());
    // return response;
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

  // Method to check if the user is authenticated
  Future<bool> isAuthenticated() async {
    final token = await _getToken();
    print("token"+token.toString());
    return token != null;
  }

  Future<void> setUser(String name, String email, String phone) async {
    await _storage.write(key: 'name', value: name);
    await _storage.write(key: 'email', value: email);
    await _storage.write(key: 'phone', value: phone);
  }

  //get user as a json
  Future<Map<String, dynamic>> getUser() async {
    final name = await _storage.read(key: 'name');
    final email = await _storage.read(key: 'email');
    final phone = await _storage.read(key: 'phone');
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}
