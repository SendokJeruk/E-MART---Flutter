import 'package:flutter/material.dart';
import 'package:e_mart_11bdg/core/errors/imageError.dart';
import 'package:e_mart_11bdg/core/services/cart_services.dart';

class CartItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback? onDelete;
  final bool isSelected;
  final ValueChanged<bool?>? onSelected;

  const CartItem({
    super.key,
    required this.item,
    this.onDelete,
    this.isSelected = false,
    this.onSelected,
  });

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

  String _formatRupiah(int value) {
    final s = value.abs().toString();
    final reg = RegExp(r'\B(?=(\d{3})+(?!\d))');
    final out = s.replaceAllMapped(reg, (m) => '.');
    return (value < 0 ? '-' : '') + out;
  }

  Future<void> _deleteItem(BuildContext context, int id) async {
    try {
      await CartServices().removeFromCart(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Produk dihapus dari keranjang")),
      );
      if (onDelete != null) onDelete!();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menghapus: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final product = (item['product'] ?? {}) as Map<String, dynamic>;
    final id = item['id'];

    String imageUrl = '';
    if ((product['foto_cover'] ?? '').toString().isNotEmpty) {
      imageUrl = product['foto_cover'];
    } else if (product['foto'] is List && (product['foto'] as List).isNotEmpty) {
      final first = (product['foto'] as List).first;
      imageUrl = first['foto'] ?? '';
    }

    final namaProduk = product['nama_product'] ?? 'Produk';
    final qty = _parseQty(item['jumlah']);
    final productPrice = _parsePrice(product['harga']);
    final itemHargaField = _parsePrice(item['harga']);
    final penjual = product['user']?['toko']?['nama_toko'] ?? product['user']?['name'] ?? 'Toko';
    final rating = product['average_rating'] ?? 0;

    int hargaSatuan;
    int subtotal;

    if (productPrice > 0) {
      hargaSatuan = productPrice;
      subtotal = hargaSatuan * qty;
    } else if (itemHargaField > 0) {
      subtotal = itemHargaField;
      hargaSatuan = qty > 0 ? (subtotal ~/ qty) : subtotal;
    } else {
      hargaSatuan = 0;
      subtotal = 0;
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: screenWidth * 0.03),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.03),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ⬅️ Checkbox untuk pilih produk
            Checkbox(
              value: isSelected,
              onChanged: onSelected,
              activeColor: Colors.red,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ErrorImageHandler(
                imageUrl: imageUrl,
                width: screenWidth * 0.22,
                height: screenWidth * 0.22,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: screenWidth * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    namaProduk,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Righteous',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Rp ${_formatRupiah(hargaSatuan)}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Jumlah: $qty",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Subtotal: Rp ${_formatRupiah(subtotal)}",
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          penjual,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "$rating",
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
