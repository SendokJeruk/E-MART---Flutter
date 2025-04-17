import 'package:flutter/material.dart';

class LoginAnimationController {
  final AnimationController controller;

  late final Animation<Offset> slide1;
  late final Animation<Offset> slide2;
  late final Animation<Offset> slide3;
  late final Animation<Offset> slide4;

  late final Animation<double> fade1;
  late final Animation<double> fade2;
  late final Animation<double> fade3;
  late final Animation<double> fade4;

  LoginAnimationController(TickerProvider vsync)
      : controller = AnimationController(
          vsync: vsync,
          duration: const Duration(milliseconds: 4000),
        ) {
    slide1 = _slide(0.0, 0.25);
    slide2 = _slide(0.25, 0.5);
    slide3 = _slide(0.5, 0.75);
    slide4 = _slide(0.75, 1.0);

    fade1 = _fade(0.0, 0.25);
    fade2 = _fade(0.25, 0.5);
    fade3 = _fade(0.5, 0.75);
    fade4 = _fade(0.75, 1.0);
  }

  Animation<Offset> _slide(double start, double end) {
    return Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(start, end, curve: Curves.easeOut),
      ),
    );
  }

  Animation<double> _fade(double start, double end) {
    return Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(start, end, curve: Curves.easeIn),
      ),
    );
  }

  void dispose() => controller.dispose();
}