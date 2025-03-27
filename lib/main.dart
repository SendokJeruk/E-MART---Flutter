import 'package:e_mart_11bdg/presentation/pages/splash.view.dart';
import 'package:flutter/material.dart';
import 'presentation/pages/login.dart';

void main() {
  runApp(const MainApp());
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
      home: SplashView(),
    );
  }
}



//statefull -> Dinamis (Berubah ubah)
//stateless -> Statis (Tetap)