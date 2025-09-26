import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: Colors.red,
          fontFamily: 'Righteous',
        ),
      ),
    );
  }
}

class PolicySection extends StatelessWidget {
  final String title;
  final String content;

  const PolicySection({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontFamily: 'Righteous',
              decoration: TextDecoration.underline,
              decorationThickness: 3,
              decorationColor: Colors.red
            ),
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFBF3131),
        title: const Text(
          "Privasi & Kebijakan",
          style: TextStyle(fontFamily: 'Righteous', color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            // Bagian Kebijakan Privasi
            SectionHeader(title: "| Kebijakan Privasi"),
            Divider(color: Colors.red, thickness: 4,),
            SizedBox(height: 10,),
            PolicySection(
              title: "1. Pendahuluan",
              content:
                  "E-Mart berkomitmen untuk melindungi privasi data Anda. Kebijakan ini menjelaskan bagaimana kami mengumpulkan, menggunakan, dan melindungi informasi pribadi pengguna.",
            ),
            PolicySection(
              title: "2. Informasi yang Dikumpulkan",
              content:
                  "Kami dapat mengumpulkan data pribadi seperti nama, email, nomor telepon, alamat pengiriman, serta data transaksi saat Anda menggunakan layanan kami.",
            ),
            PolicySection(
              title: "3. Penggunaan Data",
              content:
                  "Data digunakan untuk memproses pesanan, meningkatkan pengalaman pengguna, memberikan dukungan pelanggan, dan tujuan keamanan.",
            ),
            PolicySection(
              title: "4. Hak Pengguna",
              content:
                  "Pengguna berhak untuk mengakses, memperbarui, atau menghapus data pribadi mereka sesuai dengan ketentuan yang berlaku.",
            ),
            PolicySection(
              title: "5. Perubahan Kebijakan",
              content:
                  "Kebijakan ini dapat diperbarui sewaktu-waktu. Perubahan akan diumumkan melalui aplikasi atau email pengguna.",
            ),

            SizedBox(height: 24),

            // Bagian Kebijakan Keamanan
            SectionHeader(title: "| Kebijakan Keamanan"),
            Divider(color: Colors.red, thickness: 4,),
            SizedBox(height: 10,),
            PolicySection(
              title: "1. Keamanan Data",
              content:
                  "Kami menggunakan enkripsi, autentikasi, serta kontrol akses untuk melindungi data pribadi dari akses yang tidak sah.",
            ),
            PolicySection(
              title: "2. Perlindungan Akun",
              content:
                  "Pengguna diharapkan menjaga kerahasiaan kata sandi dan tidak membagikannya kepada pihak lain. E-Mart tidak bertanggung jawab atas penyalahgunaan akun akibat kelalaian pengguna.",
            ),
            PolicySection(
              title: "3. Aktivitas yang Mencurigakan",
              content:
                  "Jika terdeteksi adanya aktivitas mencurigakan, sistem kami berhak melakukan pembatasan atau penangguhan akun demi keamanan.",
            ),
            PolicySection(
              title: "4. Kontak Keamanan",
              content:
                  "Jika ada pertanyaan mengenai keamanan akun atau data, silakan hubungi support@emart.com.",
            ),
          ],
        ),
      ),
    );
  }
}

