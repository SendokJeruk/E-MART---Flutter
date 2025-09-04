import 'package:flutter/material.dart';

class FilterTransHistoryProvider extends ChangeNotifier {
  // Pilihan tanggal
  String _selectedDate = "Pilih Tanggal";
  String get selectedDate => _selectedDate;
  void setSelectedDate(String date) {
    _selectedDate = date;
    notifyListeners();
  }

  // Pilihan metode pembayaran
  String _selectedPayment = "Pilih Metode";
  String get selectedPayment => _selectedPayment;
  void setSelectedPayment(String method) {
    _selectedPayment = method;
    notifyListeners();
  }

  // Optional: jika kamu pakai filter tab (Semua, E-Money, dll)
  int _selectedFilter = 0;
  int get selectedFilter => _selectedFilter;
  void setFilter(int index) {
    _selectedFilter = index;
    notifyListeners();
  }
}