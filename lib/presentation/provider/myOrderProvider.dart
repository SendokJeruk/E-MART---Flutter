import 'package:flutter/material.dart';
import '../../core/models/myOrder.dart';

class OrderProvider with ChangeNotifier {
  final List<OrderItem> _orders = [
    OrderItem(
      id: "1",
      title: "Produk A",
      description: "Deskripsi produk A",
      imageUrl: "https://web-mobile-first.s3.eu-west-3.amazonaws.com/production/apple_iphone_16_pro_max_2024_min_823d6ff3f1.jpg",
      price: 50000,
      status: "Diproses",
    ),
    OrderItem(
      id: "2",
      title: "Produk B",
      description: "Deskripsi produk B",
      imageUrl: "https://web-mobile-first.s3.eu-west-3.amazonaws.com/production/apple_iphone_16_pro_max_2024_min_823d6ff3f1.jpg",
      price: 75000,
      status: "Dikirim",
    ),
  ];

  List<OrderItem> get orders => _orders;
}