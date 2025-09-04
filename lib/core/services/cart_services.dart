import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:e_mart_11bdg/core/utils/shared_prefs.dart';
import 'package:e_mart_11bdg/core/utils/constants.dart';

class CartServices {
  final String baseUrl = Constants.baseUrl;

  /// Ambil data keranjang user
  Future<Map<String, dynamic>> getCart() async {
    final token = await SharedPrefs.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/cart'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Gagal mengambil keranjang: ${response.body}");
    }
  }

  /// Tambah item ke keranjang
  Future<Map<String, dynamic>> addToCart({
    required int productId,
    required int jumlah,
  }) async {
    final token = await SharedPrefs.getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/detailcart'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: {
        'product_id': productId.toString(),
        'jumlah': jumlah.toString(),
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception("Gagal menambahkan ke keranjang: ${response.body}");
    }
  }

  /// Update jumlah item di keranjang
  Future<Map<String, dynamic>> updateCart({
    required int cartDetailId,
    required int productId,
    required int jumlah,
  }) async {
    final token = await SharedPrefs.getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/detailcart/$cartDetailId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: {
        'product_id': productId.toString(),
        'jumlah': jumlah.toString(),
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Gagal update keranjang: ${response.body}");
    }
  }

  /// Hapus item dari keranjang
  Future<Map<String, dynamic>> removeFromCart(int cartDetailId) async {
    final token = await SharedPrefs.getToken();
    final response = await http.delete(
      Uri.parse('$baseUrl/detailcart/$cartDetailId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Gagal menghapus item keranjang: ${response.body}");
    }
  }
}
