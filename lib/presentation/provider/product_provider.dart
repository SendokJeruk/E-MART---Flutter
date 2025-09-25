import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:e_mart_11bdg/core/services/product_services.dart';
import 'package:http/http.dart' as http;
import 'package:e_mart_11bdg/core/utils/shared_prefs.dart';
import 'package:e_mart_11bdg/core/utils/constants.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _productService = ProductService();

  int _perPage = 10; // awal tampil 10
  int get perPage => _perPage;

  // --- All Products
  List<dynamic> _products = [];
  List<dynamic> get products => _products;
  bool _isLoading = false;
  bool _isLoadingMore = false;

  int _currentPage = 1;
  int _lastPage = 1;

  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;

  int get currentPage => _currentPage;
  int get lastPage => _lastPage;

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
  Future<void> fetchProducts({bool loadMore = false}) async {
    if (loadMore) {
      if (_currentPage >= _lastPage) return; // sudah di halaman terakhir
      _isLoadingMore = true;
      notifyListeners();
      _currentPage++;
    } else {
      _isLoading = true;
      _currentPage = 1;
      _products = [];
      notifyListeners();
    }

    try {
      final token = await SharedPrefs.getToken();
      final res = await http.get(
        Uri.parse("${Constants.baseUrl}/product?page=$_currentPage"),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);

        final data = body['data']; // ini object paginate
        final List<dynamic> newProducts = data['data'] ?? [];

        _lastPage = data['last_page'] ?? 1;

        if (loadMore) {
          _products.addAll(newProducts); // append
        } else {
          _products = newProducts; // replace (refresh awal)
        }
      }
    } catch (e) {
      debugPrint("❌ Error fetchProducts: $e");
    }

    _isLoading = false;
    _isLoadingMore = false;
    notifyListeners();
  }

  // fungsi buat load lebih banyak
  Future<void> loadMoreProducts() async {
    _perPage = _perPage * 2; // setiap kali klik → kali 2
    await fetchProducts();
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
        Uri.parse("${Constants.baseUrl}/product?nama_product={query}"),
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

  Future<void> searchProductsByNamaProduct(String query) async {
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

      // 🔑 Gunakan Uri builder supaya query aman
      final uri = Uri.parse(
        "${Constants.baseUrl}/product",
      ).replace(queryParameters: {"nama_product": query});

      final res = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        debugPrint("🔍 Search response: $body");
        debugPrint("🔍 Body type: ${body.runtimeType}");

        if (body is Map<String, dynamic>) {
          if (body.containsKey('data')) {
            final innerData = body['data'];
            if (innerData is Map && innerData.containsKey('data')) {
              // 📌 ambil list produk dari pagination
              _searchResult = List<Map<String, dynamic>>.from(
                innerData['data'],
              );
            } else if (innerData is List) {
              _searchResult = List<Map<String, dynamic>>.from(innerData);
            } else {
              _searchResult = [];
            }
          } else {
            debugPrint("ℹ️ Tidak ada data, message: ${body['message']}");
            _searchResult = [];
          }
        } else if (body is List) {
          _searchResult = List<Map<String, dynamic>>.from(body);
        } else {
          _searchResult = [];
        }
      }
    } catch (e) {
      _searchResult = [];
      debugPrint("❌ Error searchProductsByNamaProduct: $e");
    }

    _searchLoading = false;
    notifyListeners();
  }
}
