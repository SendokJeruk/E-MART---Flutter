import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:e_mart_11bdg/data/models/User.dart';
import 'package:e_mart_11bdg/core/utils/constrants.dart';
import 'package:e_mart_11bdg/core/utils/shared_pref.dart';

class AuthService {
  Future<User?> login(String email, String password) async {
    final url = Uri.parse('${Constant.apiUrl}/auth/login');

    try {
       final response = await http.post(
        url,
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final userData = jsonResponse['data'];

        // Simpan token ke SharedPreferences
        final token = userData['access_token'];
        if (token != null) {
          await SharedPrefs.saveAccessToken(token);
          print('Token disimpan: $token');
        }

        return User.fromJson(userData);
      } else {
        return null;
      }
    } catch (e) {
      print('Error saat login: $e');
      return null;
    }
  }
}
