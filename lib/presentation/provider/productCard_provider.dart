import 'package:flutter/material.dart';

class Product {
  final String imageUrl;
  final String title;
  final String price;
  final String sold;
  final String seller;
  final double rating;

  Product({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.sold,
    required this.seller,
    required this.rating,
  });
}

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [
    Product(
      imageUrl: 'https://img-global.cpcdn.com/recipes/df9a4018d168b654/680x482cq70/macaroni-saus-spaghetti-foto-resep-utama.jpg',
      title: 'Produk A',
      price: 'Rp 10.000',
      sold: '25',
      seller: 'Toko A',
      rating: 4.5,
    ),
    Product(
      imageUrl: 'https://via.placeholder.com/150',
      title: 'Produk B',
      price: 'Rp 20.000',
      sold: '13',
      seller: 'Toko B',
      rating: 4.7,
    ),
        Product(
      imageUrl: 'https://img-global.cpcdn.com/recipes/df9a4018d168b654/680x482cq70/macaroni-saus-spaghetti-foto-resep-utama.jpg',
      title: 'Produk C',
      price: 'Rp 30.000',
      sold: '30',
      seller: 'Toko C',
      rating: 4.7,
    ),
  ];

  List<Product> get allProducts => [..._products];

  List<Product> get trendingProducts =>
      _products.where((p) => double.parse(p.sold) > 20).toList();
}
