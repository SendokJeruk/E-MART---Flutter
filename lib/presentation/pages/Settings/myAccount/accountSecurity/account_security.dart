import 'package:flutter/material.dart';
import 'package:e_mart_11bdg/data/models/User.dart';
import 'package:e_mart_11bdg/presentation/pages/editprofile.dart';

class AccountSecurity extends StatelessWidget {
  final UserModel user; // ✅ user login

  const AccountSecurity({super.key, required this.user});

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

  Widget menuItem(
    String title, {
    VoidCallback? onTap,
    String? subtitle,
  }) {
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
          ? Text(
              subtitle,
              style: const TextStyle(
                color: Color.fromARGB(255, 165, 165, 165),
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
          "Akun dan Keamanan",
          style: TextStyle(
            fontFamily: 'Righteous',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          sectionHeader("Akun"),
          menuItem(
            "Profile Saya",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditProfilePage(user: user),
                ),
              );
            },
          ),
          menuItem(
            "Username",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditProfilePage(user: user),
                ),
              );
            },
          ),
          menuItem(
            "Full Name",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditProfilePage(user: user),
                ),
              );
            },
          ),
          menuItem(
            "Email",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditProfilePage(user: user),
                ),
              );
            },
          ),
          menuItem(
            "Ganti Password",
            subtitle: "Manage your password",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditProfilePage(user: user),
                ),
              );
            },
          ),
          const SizedBox(height: 10),

          sectionHeader("Keamanan"),
        ],
      ),
    );
  }
}