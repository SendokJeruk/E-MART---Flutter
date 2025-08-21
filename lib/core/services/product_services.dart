import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../utils/shared_prefs.dart'; 

class ProductService {
  Future<List<dynamic>> getProducts() async {
    final token = await SharedPrefs.getToken();

    final res = await http.get(
      Uri.parse("${Constants.baseUrl}/product"),
      headers: {
        'Authorization': 'Bearer $token',  
        'Accept': 'application/json',
      },
    );

    if (res.statusCode == 200) {
      final body = jsonDecode(res.body) as Map<String, dynamic>;
      final paged = body['data'] as Map<String, dynamic>;
      return (paged['data'] as List<dynamic>);
    } else {
      throw Exception(
          "Gagal mengambil data produk: ${res.statusCode} - ${res.body}");
    }
  }

  Future<Map<String, dynamic>> getProductById(int id) async {
    final token = await SharedPrefs.getToken();

    final response = await http.get(
      Uri.parse("${Constants.baseUrl}/product/$id"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'];
    } else {
      throw Exception(
          "Gagal mengambil detail produk: ${response.statusCode} - ${response.body}");
    }
  }
}
