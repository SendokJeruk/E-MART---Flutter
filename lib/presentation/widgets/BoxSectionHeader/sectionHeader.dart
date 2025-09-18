import 'package:flutter/material.dart';

  Widget sectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
      child: Text(
        "| $title",
        style: const TextStyle(
          color: Colors.red,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontFamily: 'Righteous',
        ),
      ),
    );
  }