import 'package:flutter/material.dart';

class TransHistoryProvider with ChangeNotifier {
  // Pilihan filter tab: 0=Semua, 1=Pembayaran, 2=Lainnya, 3=E-Money, 4=Gagal, 5=Berhasil
  int _selectedFilter = 0;
  int get selectedFilter => _selectedFilter;
  void setFilter(int index) {
    _selectedFilter = index;
    notifyListeners();
  }

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

  // Data transaksi
  final List<Map<String, dynamic>> _allTransactions = [
    {
      "id": 1,
      "title": "Pembayaran - Gopay",
      "subtitle": "e-Money Service",
      "date": "31-07-2025",
      "amount": 10000,
      "status": "Berhasil",
      "type": "Pembayaran",
      "category": "E-Money",
    },
    {
      "id": 2,
      "title": "Topup - Dana",
      "subtitle": "Wallet Service",
      "date": "28 Juli 2025",
      "amount": 50000,
      "status": "Gagal",
      "type": "Lainnya",
      "category": "E-Money",
    },
    {
      "id": 3,
      "title": "Transfer Bank",
      "subtitle": "BCA Virtual Account",
      "date": "25 Juli 2025",
      "amount": 200000,
      "status": "Berhasil",
      "type": "Pembayaran",
      "category": "Bank",
    },
    {
      "id": 4,
      "title": "Transfer Bank",
      "subtitle": "BCA Virtual Account",
      "date": "25 Juli 2025",
      "amount": 180000,
      "status": "Pending",
      "type": "Pembayaran",
      "category": "Bank",
    },
    {
      "id": 5,
      "title": "Transfer Bank",
      "subtitle": "BCA Virtual Account",
      "date": "25 Juli 2025",
      "amount": 210000,
      "status": "Refund",
      "type": "Pembayaran",
      "category": "Bank",
    },
  ];

  // Getter transaksi yang sudah difilter
  List<Map<String, dynamic>> get transactions {
    List<Map<String, dynamic>> filtered = [];
    switch (_selectedFilter) {
      case 1:
        filtered =
            _allTransactions.where((t) => t['type'] == 'Pembayaran').toList();
        break;
      case 2:
        filtered =
            _allTransactions
                .where(
                  (t) =>
                      t['type'] == "Lainnya" ||
                      t['status'] == "Pending" ||
                      t['status'] == "Refund",
                )
                .toList();
        break;
      case 3:
        filtered = 
            _allTransactions.where((t) => t['category'] == 'E-Money').toList();
        break;
      case 4:
        filtered =  
            _allTransactions.where((t) => t['status'] == 'Gagal').toList();
        break;
      case 5:
        filtered =  
            _allTransactions.where((t) => t['status'] == 'Berhasil').toList();
        break;
      default:
        filtered = List.from(_allTransactions);
    }

  if (_selectedDate != "Pilih Tanggal") {
    filtered = filtered.where((t) => t['date'] == _selectedDate).toList();
  }

if (_selectedPayment != "Pilih Metode") {
  filtered = filtered.where((t) =>
    (t['title'] as String).toLowerCase().contains(_selectedPayment.toLowerCase())
  ).toList();
}
    return filtered;
  }
}
