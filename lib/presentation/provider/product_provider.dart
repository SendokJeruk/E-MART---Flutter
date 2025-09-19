import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:e_mart_11bdg/core/services/product_services.dart';
import 'package:http/http.dart' as http;
import 'package:e_mart_11bdg/core/utils/shared_prefs.dart';
import 'package:e_mart_11bdg/core/utils/constants.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _productService = ProductService();

  // --- All Products
  List<dynamic> _products = [];
  List<dynamic> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // --- Search Products
  List<dynamic> _searchResult = [];
  List<dynamic> get searchResult => _searchResult;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  bool _searchLoading = false;
  bool get searchLoading => _searchLoading;

  String _lastQuery = "";
  String get lastQuery => _lastQuery;

  // --- Fetch All Products
  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _productService.getProducts();
    } catch (e) {
      debugPrint("Error fetchProducts: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  // --- Search Products
  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      _isSearching = false;
      _searchResult = [];
      _lastQuery = "";
      notifyListeners();
      return;
    }

    _isSearching = true;
    _searchLoading = true;
    _lastQuery = query;
    notifyListeners();

    try {
      final token = await SharedPrefs.getToken();
      final res = await http.get(
        Uri.parse("${Constants.baseUrl}/product/search?query=$query"),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        _searchResult = body['data'] ?? [];
      } else {
        _searchResult = [];
      }
    } catch (e) {
      _searchResult = [];
      debugPrint("Error searchProducts: $e");
    }

    _searchLoading = false;
    notifyListeners();
  }

  // --- Clear Search State
  void clearSearch() {
    _isSearching = false;
    _searchResult = [];
    _lastQuery = "";
    notifyListeners();
  }
}