import 'package:flutter/material.dart';
import '../../../../../core/services/profile_services.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  bool isLoading = false;

  Future<void> changePassword() async {
    if (newPassController.text != confirmPassController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password baru tidak sama")),
      );
      return;
    }

    setState(() => isLoading = true);

    final success = await ProfileService().updateProfile(
      password: newPassController.text,
    );

    setState(() => isLoading = false);

    if (success != null) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password berhasil diubah")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal mengubah password")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ganti Password")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: oldPassController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password Lama",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: newPassController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password Baru",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: confirmPassController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Konfirmasi Password Baru",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: changePassword,
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
