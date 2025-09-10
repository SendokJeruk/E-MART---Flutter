import 'package:flutter/material.dart';

class AccountSecurity extends StatelessWidget {
  const AccountSecurity({super.key});

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
                MaterialPageRoute(builder: (_) => const AccountSecurity()
                ),
              );
            },
          ),
          menuItem(
            "Username",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AccountSecurity()),
              );
            },
          ),
          menuItem("FUll Name"),
          menuItem("Email"),
          menuItem(
            "Ganti Password",
            subtitle: "Manage your password",
          ),
          const SizedBox(height: 10),

          sectionHeader("Keamanan"),
          // menuItem("Periksa Aktivitas Akun", onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (_) => const AccountSecurity()),
          //   );
          // }),
          // menuItem("Riwayat Login", onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (_) => const AccountSecurity()),
          //   );
          // }),
        ],
      ),
    );
  }
}
