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
  int _quantity = 0;

  void _increment() {
    setState(() {
      _quantity++;
    });
  }

  void _decrement() {
    setState(() {
      if (_quantity > 0) {
        _quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<PaymentProvider>(context);

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
          height: 270,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.price,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Penjual: ${widget.seller}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text('${widget.rating} | Terjual ${widget.sold}'),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

//DESKRIPSI DAN BUTTON
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Deskripsi Produk',
                    style: TextStyle(
                      fontFamily: 'Righteous',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                 Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          productProvider.decrement();
                        },
                      ),
                      Text(
                        '${productProvider.quantity}',
                        style: const TextStyle(
                          color: Color(0xFFBF3131),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          productProvider.increment();
                          
                        },
                      ),
                    ],
                  )
                ],
              ),

              const Divider(),
              SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Color.fromARGB(255, 117, 117, 117)),
                  children: [
                    TextSpan(
                      text:
                          showFullText
                              ? widget.description
                              : firstText + (fullText.isNotEmpty ? '...' : ''),
                    ),
                    if (fullText.isNotEmpty)
                      TextSpan(
                        text: showFullText ? 'Lihat Sedikit' : 'Selengkapnya',
                        style: TextStyle(
                          color: Color(0xFFBF3131),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                setState(() {
                                  showFullText = !showFullText;
                                });
                              },
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
