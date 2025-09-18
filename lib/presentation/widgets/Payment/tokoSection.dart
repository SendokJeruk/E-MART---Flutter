import 'package:flutter/material.dart';
import 'bodyPaymentProduk.dart';

class TokoSectionWidget extends StatelessWidget {
  final double screenWidth;

  const TokoSectionWidget({
    Key? key,
    required this.screenWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // HEADER TOKO (dummy)
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
              ),
              child: ClipOval(
                child: Image.network(
                  "https://img.icons8.com/ios-filled/100/shop.png",
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.store, size: 28),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nama Toko Dummy",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Righteous', color: Color(0xFFBF3131))),
                  Text("Toko terpercaya sejak 2020", style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.chat, color: Color(0xFFBF3131))),
          ],
        ),
        const SizedBox(height: 15),

        // LIST PRODUK DUMMY (2x)
    
      ],
    );
  }
}