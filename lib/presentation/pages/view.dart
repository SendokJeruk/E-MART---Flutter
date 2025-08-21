import 'package:e_mart_11bdg/presentation/widgets/dialogCart.dart';
import 'package:e_mart_11bdg/presentation/widgets/product_skeleton.dart';
import 'package:e_mart_11bdg/presentation/widgets/shimmerSKeleton.dart';
import 'package:flutter/material.dart';
import 'package:e_mart_11bdg/presentation/widgets/product.dart';
import 'package:e_mart_11bdg/presentation/widgets/card.dart';
import 'package:e_mart_11bdg/presentation/pages/payment.dart';

class ViewPage extends StatefulWidget {
  final Map<String, dynamic> product; // data produk dari API

  const ViewPage({super.key, required this.product});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  bool isLoading = true;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1%2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final p = widget.product;

     // ambil gambar produk (cover atau foto[0])
    final String imageUrl = p['foto_cover'] ??
        ((p['foto'] is List && (p['foto'] as List).isNotEmpty)
            ? p['foto'][0]['foto']
            : '');

    // seller: toko → nama user → fallback "Toko"
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
                    rating: double.tryParse(
                            (p['average_rating'] ?? 0).toString()) ??
                        0.0,
                    description: p['deskripsi'] ?? '',
                  ),

            const SizedBox(height: 10),

            if (!isLoading)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const CartNotification(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFBF3131),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Masukkan Keranjang"),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text("|",
                          style: TextStyle(
                              fontSize: 18, color: Colors.black)),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PaymentPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFBF3131),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Order Sekarang"),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 10),
            // toggle ulasan
            GestureDetector(
              onTap: () => setState(() => isExpanded = !isExpanded),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isExpanded ? 'Sembunyikan Ulasan' : 'Tampilkan Ulasan',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFBF3131)),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: const Color(0xFFBF3131),
                  )
                ],
              ),
            ),
            if (isExpanded)
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("⭐️⭐️⭐️⭐️⭐️",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text("Produknya enak banget!"),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
