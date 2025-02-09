import 'dart:convert';
import 'package:habittracker/services/api_service.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final apiService = ApiService();

  Future<Map<String, dynamic>> signup(String email, String password, String name, String number) async {
    try {
      print("Signing up with email: $email, password: $password, name: $name, number: $number");

      final response = await apiService.post('/signup', {
        'email': email,
        'password': password,
        'name': name,
        'phone': number,
      });

      print("response"+response.headers.toString());

      if (response.statusCode == 201) {

        // final token = response.headers['authorization'];

        // if (token != null && token.isNotEmpty) {
        //   await ApiService().setToken(token);
        // } else {
        //   print("Warning: No authorization token found in the response headers.");
        // }
        return jsonDecode(response.body);

      } else {
        throw Exception("Failed to signup: ${response.body}");
      }
    } catch (e) {
      print("Signup failed: $e");
      return {'error': 'Signup failed', 'details': e.toString()};
    }
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      print("Logging in with email: $email, password: $password");

      final response = await apiService.post('/signin', {
        'email': email,
        'password': password,
      });


      if (response.statusCode == 201) {

        // final token = response.headers['authorization'];

        // if (token != null && token.isNotEmpty) {
        //   await ApiService().setToken(token);
        // } else {
        //   print("Warning: No authorization token found in the response headers.");
        // }
        return jsonDecode(response.body);

      } else {
        throw Exception("Failed to login: ${response.body}");
      }
    } catch (e) {
      print("Login failed: $e");
      return {'error': 'Login failed', 'details': e.toString()};
    }
  }
}
