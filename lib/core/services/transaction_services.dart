import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../utils/shared_prefs.dart';

class CheckoutService {
  Future<Map<String, dynamic>> checkout() async {
    final token = await SharedPrefs.getToken();

    final response = await http.post(
      Uri.parse("${Constants.baseUrl}/checkout"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
        "Checkout gagal: ${response.statusCode} - ${response.body}",
      );
    }
  }
}
