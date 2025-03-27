import 'package:flutter/material.dart';

class SplashController with ChangeNotifier {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  void init(TickerProvider vsync) {
    controller = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1500),
    );

    scaleAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.2).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(CurvedAnimation(parent: controller, curve: const Interval(0.0, 0.5)));

    fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.5, 1.0, curve: Curves.easeOut)),
    );

    slideAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(0, -1)).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.5, 1.0, curve: Curves.easeOut)),
    );
  }

  void startAnimation(VoidCallback onComplete) {
    controller.forward().then((_) => onComplete());
  }

  void dispose() {
    controller.dispose();
  }
}