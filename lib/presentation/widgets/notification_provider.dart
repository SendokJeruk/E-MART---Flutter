import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _notifications = [

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
