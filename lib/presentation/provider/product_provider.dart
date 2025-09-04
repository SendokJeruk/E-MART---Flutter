import 'package:flutter/material.dart';
import 'package:e_mart_11bdg/core/services/product_services.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _productService = ProductService();

  List<dynamic> _products = [];
  List<dynamic> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _productService.getProducts();
    } catch (e) {
      print("Error fetchProducts: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
