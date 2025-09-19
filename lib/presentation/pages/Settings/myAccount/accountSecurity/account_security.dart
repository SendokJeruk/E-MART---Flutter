import 'package:flutter/material.dart';
import 'package:e_mart_11bdg/data/models/User.dart';
import 'package:e_mart_11bdg/presentation/pages/Profile/editprofile.dart';

class AccountSecurity extends StatefulWidget {
  final UserModel user; // ✅ user login

  const AccountSecurity({super.key, required this.user});

  @override
  _AccountSecurityState createState() => _AccountSecurityState();
}

class _AccountSecurityState extends State<AccountSecurity> {
  late UserModel currentUser; // ✅ user yang bisa berubah (state)

  @override
  void initState() {
    super.initState();
    currentUser = widget.user; // isi awal
  }

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

  Future<void> _navigateToEditProfile() async {
    final updatedUser = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditProfilePage(user: currentUser),
      ),
    );

    if (updatedUser != null && mounted) {
      setState(() {
        currentUser = updatedUser; // ✅ simpan user baru
      });

      Navigator.pop(context, updatedUser);
    }
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
          menuItem("Profile Saya", onTap: _navigateToEditProfile),
          menuItem("Username", onTap: _navigateToEditProfile),
          menuItem("Full Name", onTap: _navigateToEditProfile),
          menuItem("Email", onTap: _navigateToEditProfile),
          menuItem(
            "Ganti Password",
            subtitle: "Manage your password",
            onTap: _navigateToEditProfile,
          ),
          const SizedBox(height: 10),

          sectionHeader("Keamanan"),

          // ✅ contoh pakai data terbaru
          ListTile(
            title: Text(
              "Nama saat ini: ${currentUser.name ?? '-'}",
              style: const TextStyle(fontFamily: 'Righteous'),
            ),
            subtitle: Text("Email: ${currentUser.email ?? '-'}"),
          ),
        ],
      ),
    );
  }
}