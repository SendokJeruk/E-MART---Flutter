import 'package:e_mart_11bdg/presentation/pages/DetailToko/produk.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:e_mart_11bdg/core/errors/imageError.dart';
import 'package:provider/provider.dart';
import 'package:e_mart_11bdg/presentation/provider/product_provider.dart';

class ProductDetail extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String sold;
  final String seller;
  final double rating;
  final String description;

  const ProductDetail({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.sold,
    required this.seller,
    required this.rating,
    required this.description,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool showFullText = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final String firstText = widget.description.length > 100
        ? widget.description.substring(0, 100)
        : widget.description;
    final String fullText = widget.description.length > 100
        ? widget.description.substring(100)
        : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildNetworkImageWithFallback(
          imageUrl: widget.imageUrl,
          height: screenHeight * 0.35,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(widget.price,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.w900)),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(
                          'https://cdn.pixabay.com/photo/2023/01/10/13/07/flowers-7709737_1280.jpg',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(widget.seller,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text("${widget.rating} | Terjual ${widget.sold}",
                          style: const TextStyle(fontSize: 13)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text("Deskripsi Produk",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Righteous')),
              const Divider(),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(
                        text: showFullText
                            ? widget.description
                            : firstText +
                                (fullText.isNotEmpty ? '...' : '')),
                    if (fullText.isNotEmpty)
                      TextSpan(
                        text:
                            showFullText ? '  Lihat Sedikit' : '  Selengkapnya',
                        style: const TextStyle(
                            color: Color(0xFFBF3131),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap =
                              () => setState(() => showFullText = !showFullText),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}