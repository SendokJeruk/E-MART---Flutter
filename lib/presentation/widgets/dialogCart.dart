import 'package:e_mart_11bdg/presentation/pages/cart.dart';
import 'package:e_mart_11bdg/presentation/pages/payment.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class CartNotification extends StatelessWidget {
  const CartNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('TERIMAKASIH !', style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFFBF3131),
        fontFamily: 'Righteous'
      ),),
      content: const Text('Barang kamu sudah masuk keranjang nih!\n\nJangan lupa checkout ya!', style: TextStyle(
        fontSize: 16,
        color: Color.fromARGB(255, 30, 30, 30),
        fontFamily: 'Poppins'
      ),),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage(),
              ),
            );
          },
          child: const Text(
            'Lihat Keranjang',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFFBF3131),
              fontFamily: 'Righteous',
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'OK',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFFBF3131),
              fontFamily: 'Righteous',
            ),
          ),
        ),
      ],
    );
  }
}
