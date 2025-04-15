import 'package:flutter/material.dart';

class LoginAnimationController {
  final AnimationController controller;
  final List<Animation<Offset>> itemAnimations;

  LoginAnimationController({required TickerProvider vsync})
      : controller = AnimationController(
          vsync: vsync,
          duration: Duration(milliseconds: 1200),
        ),
        itemAnimations = List.generate(4, (i) {
          return Tween<Offset>(
            begin: Offset(0, 1),
            end: Offset(0, 0),
          ).animate(
            CurvedAnimation(
              parent: AnimationController(
                vsync: vsync,
                duration: Duration(milliseconds: 1200),
              ),
              curve: Interval(
                0.2 * i,
                0.6 + 0.2 * i,
                curve: Curves.easeOutBack,
              ),
            ),
          );
        });

  void start() {
    controller.forward();
  }

  void dispose() {
    controller.dispose();
  }
}