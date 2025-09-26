import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:e_mart_11bdg/core/utils/shared_prefs.dart';
import 'package:e_mart_11bdg/core/utils/constants.dart';
import 'package:e_mart_11bdg/data/models/transaction.dart';

class TransactionService {
  final String baseUrl = Constants.baseUrl;


  /// GET /transaction?kode_transaksi=xxx
  Future<Transaction> getTransactionByKode(String kodeTransaksi) async {
    final token = await SharedPrefs.getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/transaction?kode_transaksi=$kodeTransaksi"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return Transaction.fromJson(data);
    } else {
      throw Exception("Failed to load transaction");
    }
  }

  /// GET /transaction/get-transaction-detail/{kode}
  Future<List<Map<String, dynamic>>> getTransactionDetail(String kodeTransaksi) async {
    final token = await SharedPrefs.getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/transaction/get-transaction-detail/$kodeTransaksi"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'] as List;
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception("Failed to load transaction detail");
    }
  }

  /// PUT /transaction/{kode}
  Future<Transaction> updateTransaction(
      String kodeTransaksi, Map<String, dynamic> body) async {
    final token = await SharedPrefs.getToken();
    final response = await http.put(
      Uri.parse("$baseUrl/transaction/$kodeTransaksi"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return Transaction.fromJson(data);
    } else {
      throw Exception("Failed to update transaction");
    }
  }
}
