import 'package:e_mart_11bdg/presentation/pages/Settings/myAccount/accountSecurity/account_security.dart';
import 'package:e_mart_11bdg/presentation/pages/Settings/myAccount/accountAddress/myAddress.dart';
import 'package:e_mart_11bdg/presentation/pages/Settings/userSettings/Notification/listNotif.dart';
import 'package:e_mart_11bdg/presentation/pages/paymentMethod.dart';
import 'package:flutter/material.dart';
import 'package:e_mart_11bdg/data/models/User.dart';

class SettingsPage extends StatelessWidget {
  final UserModel user; // ✅ sekarang butuh user

  const SettingsPage({super.key, required this.user});

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
      subtitle: subtitle != null
          ? Text(subtitle,
              style: const TextStyle(
                  color: Color.fromARGB(255, 165, 165, 165)))
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
          "Settings",
          style: TextStyle(
            fontFamily: 'Righteous',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          sectionHeader("Akun Saya"),
          menuItem("Akun & Keamanan", onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AccountSecurity(user: user), // ✅ kirim user
              ),
            );
          }),
          menuItem("Alamat Saya", onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MyaddressPage()),
            );
          }),

          sectionHeader("Pengaturan"),
          menuItem("Notifikasi", onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationList()),
            );
          }),
          menuItem("Blokir Pengguna"),
          menuItem("Privasi"),
          menuItem("Bahasa / Language", subtitle: "Bahasa Indonesia"),

          sectionHeader("Bantuan"),
          menuItem("Kebijakan E-Mart"),
          menuItem("Informasi"),
          menuItem("Ajukan HAPUS AKUN"),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}