import 'package:e_mart_11bdg/data/models/productApi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductApiService {
  static const String baseUrl = '';

  Future<List<Post>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Post>.from(data['data'].map((x) => Post.fromJson(x)));
    } else {
      throw Exception('Gagal mengambil data produk');
    }
  }

  // Bisa tambah createProduct, updateProduct, deleteProduct, dsb.
}