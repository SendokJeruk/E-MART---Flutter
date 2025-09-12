import 'package:flutter/material.dart';
import 'package:e_mart_11bdg/presentation/widgets/dialogCart.dart';
import 'package:e_mart_11bdg/presentation/widgets/product_skeleton.dart';
import 'package:e_mart_11bdg/presentation/widgets/shimmerSKeleton.dart';
import 'package:e_mart_11bdg/presentation/widgets/product.dart';
import 'package:e_mart_11bdg/presentation/pages/Payment/payment.dart';
import 'package:e_mart_11bdg/core/services/cart_services.dart';



class ViewPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ViewPage({super.key, required this.product});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  bool isLoading = true;
  bool isAdding = false; // untuk indikator saat menambah keranjang
  int jumlah = 1;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> _addToCart() async {
    if (isAdding) return; // cegah double tap
    setState(() => isAdding = true);

    try {
      await CartServices().addToCart(
        productId: widget.product['id'],
        jumlah: jumlah,
      );

      if (mounted) {
        Navigator.pop(context, true); // kasih sinyal refresh ke CartPage
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Produk ditambahkan ke keranjang")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal menambah ke keranjang: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => isAdding = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;

    final String imageUrl = p['foto_cover'] ??
        ((p['foto'] is List && (p['foto'] as List).isNotEmpty)
            ? p['foto'][0]['foto']
            : '');

    final String seller = (p['user']?['toko']?['nama_toko']) ??
        (p['user']?['name']) ??
        'Toko';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFBF3131),
        foregroundColor: Colors.white,
        title: const Text(
          "Detail Produk",
          style: TextStyle(
            fontFamily: 'Righteous',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            isLoading
                ? const ProductSkeleton()
                : ProductDetail(
                imageUrl: imageUrl,
                title: p['nama_product'] ?? '',
                price: "Rp ${p['harga']}",
                sold: (p['sold'] ?? p['stock'] ?? 0).toString(),
                seller: seller,
                rating: double.tryParse((p['average_rating'] ?? 0).toString()) ?? 0.0,
                description: p['deskripsi'] ?? '',
                onQuantityChanged: (val) => setState(() => jumlah = val), // 🔹 terima jumlah dari ProductDetail
              ),

            if (!isLoading)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // 🔹 tombol aksi
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: isAdding ? null : _addToCart,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFBF3131),
                              foregroundColor: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: isAdding
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text("Masukkan Keranjang"),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text("|", style: TextStyle(fontSize: 18)),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const PaymentPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFBF3131),
                              foregroundColor: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text("Order Sekarang"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}