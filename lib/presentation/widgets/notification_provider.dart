import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _notifications = [
    {
      "icon": Icons.new_releases,
      "title": "Produk Terbaru!",
      "desc": "Smartphone XYZ kini tersedia dengan fitur canggih.",
    },
    {
      "icon": Icons.local_offer,
      "title": "Promo Hari Ini",
      "desc": "Diskon 50% untuk semua produk hingga jam 12 malam!",
    },
    {
      "icon": Icons.local_shipping,
      "title": "Status Pesanan",
      "desc": "Pesanan kamu sedang dalam perjalanan. Tunggu sebentar lagi!",
    },

  ];

  List<Map<String, dynamic>> get notifications => _notifications;

  int get count => _notifications.length;

  void addNotification(IconData icon, String title, String desc) {
    _notifications.insert(0, {
      "icon": icon,
      "title": title,
      "desc": desc,
    });
    notifyListeners();
  }

  void clearNotifications() {
    _notifications.clear();
    notifyListeners();
  }
}
