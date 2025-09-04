import 'dart:developer';

import 'package:e_mart_11bdg/presentation/pages/Profile.dart';
import 'package:e_mart_11bdg/presentation/pages/Profile/orderList.dart';
import 'package:e_mart_11bdg/presentation/pages/Settings/myAccount/accountAddress/addAddress.dart';
import 'package:e_mart_11bdg/presentation/pages/Settings/myAccount/accountAddress/myAddress.dart';
import 'package:e_mart_11bdg/presentation/pages/Settings/myAccount/accountSecurity/account_security.dart';
import 'package:e_mart_11bdg/presentation/pages/Settings/settings.dart';
import 'package:e_mart_11bdg/presentation/pages/Transaksi/detailTransaksi.dart';
import 'package:e_mart_11bdg/presentation/pages/Transaksi/trackingHistory.dart';
import 'package:e_mart_11bdg/presentation/pages/Transaksi/transHistory.dart';
import 'package:e_mart_11bdg/presentation/pages/home.dart';
import 'package:e_mart_11bdg/presentation/pages/notifikasi.dart';
import 'package:e_mart_11bdg/presentation/pages/payment.dart';
import 'package:e_mart_11bdg/presentation/pages/service.dart';
import 'package:e_mart_11bdg/presentation/pages/splash.view.dart';
import 'package:e_mart_11bdg/presentation/provider/Transaksi/transactionProvider.dart';
import 'package:e_mart_11bdg/presentation/provider/addressProvider.dart';
import 'package:e_mart_11bdg/presentation/provider/kategori_provider.dart';
import 'package:e_mart_11bdg/presentation/provider/location_provider.dart';
import 'package:e_mart_11bdg/presentation/pages/cart.dart';
import 'package:e_mart_11bdg/presentation/provider/myOrderProvider.dart';
import 'package:e_mart_11bdg/presentation/provider/product_provider.dart';
import 'package:e_mart_11bdg/presentation/provider/productList_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/widgets/notification_provider.dart';
import 'presentation/pages/login.dart';
import 'presentation/pages/view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'presentation/pages/DetailToko/produk.dart';
import 'presentation/provider/tab_provider.dart';
import '../presentation/provider/addressProvider.dart';
import 'presentation/provider/Transaksi/trackingStep.dart';

// ⬇️ Tambahan import
import 'presentation/provider/detailOrderProvider.dart';
import '../../presentation/pages/Transaksi/detailTransaksi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
        // ChangeNotifierProvider(create: (context) => PaymentProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => TabProvider()),
        ChangeNotifierProvider(create: (_) => KategoriProvider()),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
        ChangeNotifierProvider(create: (_) => TrackingProvider()),
        ChangeNotifierProvider(create: (_) => DetailTransProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => TransHistoryProvider()),
        ChangeNotifierProvider(create: (_) {
          final provider = DetailTransProvider();
          provider.loadDummyData(); 
          return provider;
        }),
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
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
    );
  }
}