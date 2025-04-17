import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedLogoItem extends StatelessWidget {
  final Animation<Offset> animation;
  final Animation<double> fadeAnimation;
  final String svgPath;
  final double width;

  const AnimatedLogoItem({
    super.key,
    required this.animation,
    required this.fadeAnimation,
    required this.svgPath,
    required this.width, required double topOffset,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: SvgPicture.asset(
          svgPath,
          width: width,
        ),
      ),
    );
  }
}