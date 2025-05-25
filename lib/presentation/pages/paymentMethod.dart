import 'package:flutter/material.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  void _selectMethod(BuildContext context, String method) {
    Navigator.pop(context, method);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pilih Transfer'),
        backgroundColor: const Color(0xFFBF3131),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Bank Transfer',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: const Text('BCA'),
              onTap: () => _selectMethod(context, 'Transfer : BCA'),
            ),
            ListTile(
              title: const Text('Mandiri'),
              onTap: () => _selectMethod(context, 'Transfer : Mandiri'),
            ),
            ListTile(
              title: const Text('BNI'),
              onTap: () => _selectMethod(context, 'Transfer : BNI'),
            ),
            const SizedBox(height: 20),
            const Text(
              'E-Wallet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: const Text('Dana'),
              onTap: () => _selectMethod(context, 'E-Wallet : Dana'),
            ),
            ListTile(
              title: const Text('Gopay'),
              onTap: () => _selectMethod(context, 'E-Wallet : Gopay'),
            ),
            ListTile(
              title: const Text('OVO'),
              onTap: () => _selectMethod(context, 'E-Wallet : OVO'),
            ),
            ListTile(
              title: const Text('ShopeePay'),
              onTap: () => _selectMethod(context, 'E-Wallet : ShopeePay'),
            ),
          ],
        ),
      ),
    );
  }
}