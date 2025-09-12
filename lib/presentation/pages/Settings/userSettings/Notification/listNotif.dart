import 'package:e_mart_11bdg/presentation/pages/Settings/myAccount/accountSecurity/account_security.dart';
import 'package:flutter/material.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget sectionHeader(String title) {
    return Container(
      width: double.infinity,
      color: Colors.red[700],
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Text(
        "| $title",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Righteous',
        ),
      ),
    );
  }

  Widget menuItem(String title, {VoidCallback? onTap, String? subtitle}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Righteous',
          fontSize: 16,
          color: Colors.red,
        ),
      ),
      subtitle:
          subtitle != null
              ? Text(
                subtitle,
                style: TextStyle(
                  color: const Color.fromARGB(255, 165, 165, 165),
                ),
              )
              : null,
      trailing: const Icon(Icons.chevron_right, color: Colors.red),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFBF3131),
        foregroundColor: Colors.white,
        title: const Text(
          "Notifikasi",
          style: TextStyle(
            fontFamily: 'Righteous',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          menuItem(
            "Notifikasi Aplikasi",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationList()),
              );
            },
          ),
          menuItem(
            "Notifikasi Banner di Aplikasi",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationList()),
              );
            },
          ),
          menuItem(
            "Notifikasi Email",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationList()),
              );
            },
          ),
        ],
      ),
    );
  }
}
