import 'package:flutter/material.dart';


  Widget boxContent({required double screenWidth, required Widget child}) {
    return Container(
      width: screenWidth * 0.9,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 12)],
      ),
      child: child,
    );
  }