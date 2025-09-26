import 'package:e_mart_11bdg/presentation/pages/Payment/detail_transaction.dart';
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
  Set<int> selectedItems = {}; // ⬅️ simpan item terpilih

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

  String _formatRupiah(int value) {
    final s = value.abs().toString();
    final reg = RegExp(r'\B(?=(\d{3})+(?!\d))');
    final out = s.replaceAllMapped(reg, (m) => '.');
    return (value < 0 ? '-' : '') + out;
  }

  int _calculateSelectedSubtotal(List items) {
  return items.fold(0, (sum, item) {
    final map = item as Map<String, dynamic>;
    if (selectedItems.contains(map['id'])) {
      return sum + _itemSubtotal(map);
    }
    return sum;
  });
}

int _calculateSelectedQuantity(List items) {
  return items.fold(0, (sum, item) {
    final map = item as Map<String, dynamic>;
    if (selectedItems.contains(map['id'])) {
      return sum + _parseQty(map['jumlah']);
    }
    return sum;
  });
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
      actions: [
        if (selectedItems.isNotEmpty) // hanya muncul jika ada produk dipilih
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text("Hapus Produk"),
                  content: const Text("Apakah Anda yakin ingin menghapus produk yang dipilih?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text("Batal"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: const Text("Hapus", style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                for (final id in selectedItems) {
                  try {
                    await CartServices().removeFromCart(id);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Gagal menghapus item $id: $e")),
                    );
                  }
                }
                setState(() {
                  selectedItems.clear();
                  _cartFuture = CartServices().getCart();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Produk berhasil dihapus")),
                );
              }
            },
          ),
      ],
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
          final selectedSubtotal = _calculateSelectedSubtotal(cartDetails);
          final selectedQty = _calculateSelectedQuantity(cartDetails);


          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refreshCart,
                  child: ListView.builder(
                  itemCount: cartDetails.length,
                  itemBuilder: (context, index) {
                    final item = cartDetails[index] as Map<String, dynamic>;
                    final id = item['id'] as int;

                      return CartItem(
                        item: item,
                        onDelete: _refreshCart,
                        isSelected: selectedItems.contains(id),
                        onSelected: (selected) {
                          setState(() {
                            if (selected == true) {
                              selectedItems.add(id);
                            } else {
                              selectedItems.remove(id);
                            }
                          });
                        },
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
                        '$selectedQty produk dipilih',
                        style: const TextStyle(
                          fontFamily: 'Righteous',
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Subtotal: Rp ${_formatRupiah(selectedSubtotal)}',
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
                      onPressed: selectedItems.isEmpty
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailTransactionPage(
                                    selectedIds: selectedItems.toList(), // ⬅️ kirim ke payment
                                  ),
                                ),
                              );
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