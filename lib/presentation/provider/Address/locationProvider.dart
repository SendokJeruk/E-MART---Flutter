import 'package:flutter/foundation.dart';

class LocationProvider with ChangeNotifier {
  String _address = "";
  Map<String, dynamic>? _selectedAddress; // simpan object alamat

  String get address => _address;
  Map<String, dynamic>? get selectedAddress => _selectedAddress;

  void setManualAddress(Map<String, dynamic> alamat) {
    _selectedAddress = alamat;
    _address = alamat['label'] ?? "";
    notifyListeners();
  }

  void clearAddress() {
    _selectedAddress = null;
    _address = "";
    notifyListeners();
  }
}