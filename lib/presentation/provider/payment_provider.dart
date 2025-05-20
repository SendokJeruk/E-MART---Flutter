import 'package:flutter/material.dart';

class PaymentProvider with ChangeNotifier {
  int _quantity = 1;
  final int _pricePerItem = 100000;
  final int _serviceFee = 5000;

  int get quantity => _quantity;
  int get pricePerItem => _pricePerItem;
  int get serviceFee => _serviceFee;
  int get subTotal => (_pricePerItem * _quantity) + _serviceFee;

  void increment() {
    _quantity++;
    notifyListeners();
  }

  void decrement() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }
}
