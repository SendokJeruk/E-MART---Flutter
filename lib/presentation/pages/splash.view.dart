import 'dart:async';
import 'package:flutter/material.dart';
import 'package:e_mart_11bdg/presentation/pages/home.dart';
import 'package:e_mart_11bdg/data/controllers/animate.controllers.dart';
import 'package:e_mart_11bdg/presentation/routes/routeTransition.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  final SplashController _splashController = SplashController();

  @override
  void initState() {
    super.initState();
    _splashController.init(this);

    Future.delayed(const Duration(seconds: 2), () {
      _splashController.startAnimation(() {
        Navigator.of(context).pushReplacement(
          FadeSlideRoute(page: const HomePage()),
        );
      });
    });
  }

  @override
  void dispose() {
    _splashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _splashController.controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _splashController.fadeAnimation,
              child: SlideTransition(
                position: _splashController.slideAnimation,
                child: ScaleTransition(
                  scale: _splashController.scaleAnimation,
                  child: child,
                ),
              ),
            );
          },
          child: Image.asset(
            'assets/images/emart.png',
            width: 200,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}