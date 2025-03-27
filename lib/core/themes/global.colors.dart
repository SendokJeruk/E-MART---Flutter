import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class GlobalColors {
  static HSVColor mainColor = HexColor('#1E319D') as HSVColor;
  static HSVColor textColor = HexColor('#4F4F4F') as HSVColor;
}

class HexColor {
  HexColor(String s);
}
