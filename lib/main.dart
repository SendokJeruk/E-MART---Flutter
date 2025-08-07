import 'dart:developer';

import 'package:e_mart_11bdg/presentation/pages/Profile.dart';
import 'package:e_mart_11bdg/presentation/pages/home.dart';
import 'package:e_mart_11bdg/presentation/pages/notifikasi.dart';
import 'package:e_mart_11bdg/presentation/pages/payment.dart';
import 'package:e_mart_11bdg/presentation/pages/service.dart';
import 'package:e_mart_11bdg/presentation/pages/splash.view.dart';
import 'package:e_mart_11bdg/presentation/provider/location_provider.dart';
import 'package:e_mart_11bdg/presentation/pages/cart.dart';
import 'package:e_mart_11bdg/presentation/provider/product_provider.dart';
import 'package:e_mart_11bdg/presentation/provider/productCard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/widgets/notification_provider.dart';
import 'presentation/pages/login.dart';
import './presentation/pages/view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'presentation/pages/DetailToko/produk.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
        ChangeNotifierProvider(create: (context) => PaymentProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: const MainApp(),
    ),
  );
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashView(),
    );
  }
}