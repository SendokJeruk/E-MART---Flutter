// core/services/checkout_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:e_mart_11bdg/core/utils/shared_prefs.dart';
import 'package:e_mart_11bdg/core/utils/constants.dart';
import 'package:e_mart_11bdg/data/models/transaction.dart';

class CheckoutService {
  final String baseUrl = Constants.baseUrl;

  Future<Transaction?> checkoutProducts(List<int> cartDetailIds) async {
    try {
      final token = await SharedPrefs.getToken();

      final response = await http.post(
        Uri.parse("$baseUrl/checkout/products"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "cart_detail_ids": cartDetailIds,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body)['data'];
        return Transaction.fromJson(data);
      } else {
        print("Checkout gagal: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error checkout: $e");
      return null;
    }
  }
}
