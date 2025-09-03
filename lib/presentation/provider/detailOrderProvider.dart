import 'package:flutter/material.dart';
import '../../core/models/detailTrans.dart';

class DetailTransProvider with ChangeNotifier {
  DetailTrans? _detail;

  DetailTrans? get detail => _detail;

  void loadDummyData() {
    _detail = DetailTrans(
      status: "Pesanan Diterima",
      orderId: "XXXXXXXXXX",
      courier: "SPX Standard",
      trackingNumber: "xxxxxxxxx",
      shippingStatus: "Pesanan diterima oleh [username]!",
      address: "Jl. Cigugur Tengah No.068 07/10, Cimahi",
      paymentMethod: "Bank Transfer",
      sellerNote: "[TEXT FIELD]",
      products: [
        {
          "status": "Delivered",
          "name": "Product Name",
          "description": "Detail Pembelian Singkat",
          "quantity": 10,
          "price": 0,
          "isPreOrder": true,
        },
      ],
    );
    notifyListeners();
  }

  void loadFromDatabase(DetailTrans detail) {
    _detail = detail;
    notifyListeners();
  }
}