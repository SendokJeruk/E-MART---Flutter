import 'package:e_mart_11bdg/presentation/pages/Settings/settings.dart';
import 'package:e_mart_11bdg/presentation/pages/Profile/orderList.dart';
import 'package:e_mart_11bdg/presentation/pages/Transaksi/transHistory.dart';
import 'package:flutter/material.dart';
import 'package:e_mart_11bdg/core/utils/shared_prefs.dart';
import 'package:e_mart_11bdg/presentation/pages/login.dart';
import 'package:e_mart_11bdg/presentation/widgets/bottom_bar.dart';
import 'package:e_mart_11bdg/core/services/profile_services.dart';
import 'package:e_mart_11bdg/data/models/User.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    final profileData = await ProfileService().getProfile();
    setState(() {
      user = profileData;
      isLoading = false;
    });
  }

  Widget infoRow(String label, String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$label :",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
            fontFamily: 'Righteous',
          ),
        ),
        Flexible(
          child: Text(
            value ?? "-",
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget actionRow(String label, IconData icon,
      {required VoidCallback onTap, double iconSize = 20}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 88, 88, 88),
                fontFamily: 'Righteous',
              ),
            ),
            Icon(icon, size: iconSize, color: const Color(0xFFBF3131)),
          ],
        ),
      ),
    );
  }

  Widget actionButton(String text, VoidCallback onTap) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFBF3131),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Righteous',
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          backgroundColor: const Color(0xFFBF3131),
          foregroundColor: Colors.white,
          title: const Text(
            "Profile",
            style: TextStyle(
              fontFamily: 'Righteous',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // FOTO PROFILE
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFBF3131),
                            width: 5,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            user?.fotoProfil ?? 'https://via.placeholder.com/150',
                            width: 110,
                            height: 110,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 110,
                              height: 110,
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.broken_image, size: 40),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        user?.name ?? '',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Righteous',
                          color: Color(0xFFBF3131),
                        ),
                      ),
                      Text(
                        user?.email ?? '',
                        style: TextStyle(
                          fontFamily: 'Righteous',
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // INFORMASI USER
                      Container(
                        width: screenWidth * 0.9,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            infoRow("Nama Lengkap", user?.name),
                            const Divider(color: Colors.white),
                            infoRow("Email", user?.email),
                            const Divider(color: Colors.white),
                            infoRow("No. Telp", user?.noTelp ?? "-"),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Divider(color: Colors.red),
                            ),
                            actionRow(
                              "Dompet Saya",
                              Icons.account_balance_wallet,
                              iconSize: 20,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        SettingsPage(user: user!), // ✅ kirim user
                                  ),
                                );
                              },
                            ),
                            const Divider(color: Colors.white),
                            actionRow(
                              "Pesanan Saya",
                              Icons.shopping_bag,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const OrdersPage(),
                                  ),
                                );
                              },
                            ),
                            const Divider(color: Colors.white),
                            actionRow(
                              "Pengaturan",
                              Icons.settings,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        SettingsPage(user: user!), // ✅ kirim user
                                  ),
                                );
                              },
                            ),
                            const Divider(color: Colors.white),
                            actionRow(
                              "Riwayat Transaksi",
                              Icons.payment,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const TransHistory()),
                                );
                              },
                            )
                          ],
                        ),
                      ),

                      // GARIS PEMBATAS
                      const SizedBox(height: 16),
                      Container(
                        width: screenWidth,
                        height: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFBF3131),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      // BUTTONS
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          actionButton("LOG OUT", () async {
                            await SharedPrefs.clearToken();
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (_) => const LoginPage(),
                              ),
                              (route) => false,
                            );
                          }),
                          const SizedBox(width: 10),
                          actionButton("SWITCH ACCOUNT", () {
                            print("Switch account tapped");
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
      bottomNavigationBar: const BottomBar(currentIndex: 4),
    );
  }
}