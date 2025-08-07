import 'package:flutter/material.dart';
import 'package:e_mart_11bdg/data/models/Kategori.dart';

class KategoriProvider with ChangeNotifier {
  List<Kategori> _kategoriList = [];

  List<Kategori> get kategoriList => _kategoriList;

  Future<void> fetchKategori() async {
    // Simulasi dari database / API
    await Future.delayed(Duration(seconds: 1));
    _kategoriList = [
      Kategori(nama: "Makanan", jumlah: 16),
      Kategori(nama: "Minuman", jumlah: 6),
      Kategori(nama: "Bahan-Bahan", jumlah: 80),
      Kategori(nama: "Pasti Murah", jumlah: 3),
    ];
    notifyListeners();
  }
}