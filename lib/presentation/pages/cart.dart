import 'package:flutter/material.dart';
import 'package:e_mart_11bdg/core/services/cart_services.dart';
import 'package:e_mart_11bdg/presentation/widgets/cart_item.dart';
import 'package:e_mart_11bdg/presentation/pages/Payment/payment.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<Map<String, dynamic>> _cartFuture;

  @override
  void initState() {
    super.initState();
    _cartFuture = CartServices().getCart();
  }

  Future<void> _refreshCart() async {
    setState(() {
      _cartFuture = CartServices().getCart();
    });
    await _cartFuture;
  }

  int _parsePrice(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    if (v is double) return v.round();
    if (v is String) {
      final cleaned = v.replaceAll(RegExp(r'[^0-9]'), '');
      return int.tryParse(cleaned) ?? 0;
    }
    return 0;
  }

  int _parseQty(dynamic v) {
    if (v == null) return 1;
    if (v is int) return v;
    if (v is double) return v.round();
    if (v is String) return int.tryParse(v) ?? 1;
    return 1;
  }

  int _itemSubtotal(Map<String, dynamic> item) {
    final product = (item['product'] ?? {}) as Map<String, dynamic>;
    final qty = _parseQty(item['jumlah']);
    final productPrice = _parsePrice(product['harga']);
    final itemHargaField = _parsePrice(item['harga']);

    if (productPrice > 0) {
      return productPrice * qty;
    } else if (itemHargaField > 0) {
      return itemHargaField;
    } else {
      return 0;
    }
  }

  int _calculateSubtotal(List items) {
    return items.fold(0, (sum, item) => sum + _itemSubtotal(item as Map<String, dynamic>));
  }

  int _calculateTotalQuantity(List items) {
    return items.fold(0, (sum, item) => sum + _parseQty((item as Map<String, dynamic>)['jumlah']));
  }

  String _formatRupiah(int value) {
    final s = value.abs().toString();
    final reg = RegExp(r'\B(?=(\d{3})+(?!\d))');
    final out = s.replaceAllMapped(reg, (m) => '.');
    return (value < 0 ? '-' : '') + out;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFBF3131),
        title: const Text(
          'Keranjang',
          style: TextStyle(
            fontFamily: 'Righteous',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _cartFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFBF3131)));
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || (snapshot.data!['data'] == null) || (snapshot.data!['data'] as List).isEmpty) {
            return const Center(child: Text("Keranjang masih kosong"));
          }

          final carts = snapshot.data!['data'] as List;
          final cartDetails = carts.first['cart_detail'] as List;
          final subtotal = _calculateSubtotal(cartDetails);
          final totalQuantity = _calculateTotalQuantity(cartDetails);

          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refreshCart,
                  child: ListView.builder(
                    itemCount: cartDetails.length,
                    itemBuilder: (context, index) {
                      final item = cartDetails[index] as Map<String, dynamic>;
                      return CartItem(
                        item: item,
                        onDelete: _refreshCart,
                      );
                    },
                  ),
                ),
              ),
              Container(
                width: screenWidth,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.02,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.grey.shade300)),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, -1)),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$totalQuantity produk',
                          style: const TextStyle(
                            fontFamily: 'Righteous',
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Subtotal: Rp ${_formatRupiah(subtotal)}',
                          style: const TextStyle(
                            fontFamily: 'Righteous',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentPage()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1,
                          vertical: screenHeight * 0.015,
                        ),
                      ),
                      child: const Text(
                        'Checkout',
                        style: TextStyle(
                          fontFamily: 'Righteous',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
