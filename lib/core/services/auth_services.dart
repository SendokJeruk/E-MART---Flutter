import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../utils/shared_prefs.dart';

class AuthService {
  Future<bool> register({
    required String name,
    required String email,
    required String noTelp,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('${Constants.baseUrl}/auth/register'),
      body: {
        'name': name,
        'email': email,
        'no_telp': noTelp,
        'password': password,
      },
    );

    print('REGISTER STATUS: ${response.statusCode}');
    print('REGISTER BODY: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return true;
    }

    return false;
  }

  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.baseUrl}/auth/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      print('LOGIN STATUS: ${response.statusCode}');
      print('LOGIN BODY: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final token = data['data']['access_token'];

        if (token != null) {
          await SharedPrefs.saveToken(token);
          return true;
        }
      } else {
        print('Login failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error saat login: $e');
    }

    return false;
  }

  Future<bool> logout() async {
    final token = await SharedPrefs.getToken();
    if (token == null) return false;

    final response = await http.post(
      Uri.parse('${Constants.baseUrl}/auth/logout'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    print('LOGOUT STATUS: ${response.statusCode}');
    if (response.statusCode == 200) {
      await SharedPrefs.clearToken();
      return true;
    } else {
      print('Logout gagal, status: ${response.statusCode}');
      return false;
    }
  }
}
