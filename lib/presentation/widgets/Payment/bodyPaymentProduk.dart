import 'package:flutter/material.dart';
import '../BoxSectionHeader/boxProdukPayment.dart';

class ProdukPaymentWidget extends StatelessWidget {
  final int index;
  final double screenWidth;

  const ProdukPaymentWidget({
    super.key,
    required this.index,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return productPayment(
      screenWidth: screenWidth,
      child: Row(
        children: [
          // Foto Produk
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 9),
              ],
              borderRadius: BorderRadius.circular(9),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Image.network(
                "https://img-global.cpcdn.com/recipes/df9a4018d168b654/680x482cq70/macaroni-saus-spaghetti-foto-resep-utama.jpg",
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Info Produk dummy
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama Produk ${index + 1}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Righteous',
                    color: Color(0xFFBF3131),
                  ),
                ),
                const Text(
                  "Rp. 10.000",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFBF3131),
                    fontFamily: 'Righteous',
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Jumlah Barang",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "1000",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}