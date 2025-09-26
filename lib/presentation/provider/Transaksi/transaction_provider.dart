import 'package:flutter/material.dart';
import 'package:e_mart_11bdg/data/models/transaction.dart';
import 'package:e_mart_11bdg/core/services/transaction_service.dart';

class TransactionProvider with ChangeNotifier {
  final TransactionService _transactionService = TransactionService();

  Transaction? _transaction;
  Transaction? get transaction => _transaction;

  List<Map<String, dynamic>> _transactionDetail = [];
  List<Map<String, dynamic>> get transactionDetail => _transactionDetail;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// Ambil transaksi berdasarkan kode
  Future<void> fetchTransactionByKode(String kodeTransaksi) async {
    _isLoading = true;
    notifyListeners();

    try {
      final trx = await _transactionService.getTransactionByKode(kodeTransaksi);
      _transaction = trx;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Ambil detail transaksi (group by toko)
  Future<void> fetchTransactionDetail(String kodeTransaksi) async {
    _isLoading = true;
    notifyListeners();

    try {
      final detail =
          await _transactionService.getTransactionDetail(kodeTransaksi);
      _transactionDetail = detail;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Update transaksi (ongkir / status)
  Future<void> updateTransaction(
      String kodeTransaksi, Map<String, dynamic> body) async {
    _isLoading = true;
    notifyListeners();

    try {
      final updated =
          await _transactionService.updateTransaction(kodeTransaksi, body);
      _transaction = updated;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
