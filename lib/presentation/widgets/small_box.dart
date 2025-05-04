import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SmallBox extends StatelessWidget {
  final String title;
  final double size; // opsional biar fleksibel
  final IconData icon;

  const SmallBox({
    Key? key,
    required this.title,
    required this.icon,
    this.size = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: Color.fromARGB(255, 191, 49, 49),
              width: 0.1,
            ),
          ),
          //FA ICON
          child: Center(
            child: FaIcon(icon, color: Color(0xFFBF3131), size: size * 0.5),
          ),
        ),
        //TITLE
        SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            fontFamily: 'Righteous',
          ),
        ),
      ],
    );
  }
}
