import 'package:flutter/material.dart';

Widget productPayment({required screenWidth, required Widget child}) {
  return Container(
   width: screenWidth * 0.9,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 12)],
      ),
    child: child,
  );
}
