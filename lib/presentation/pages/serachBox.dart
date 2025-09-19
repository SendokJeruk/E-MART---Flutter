import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_mart_11bdg/presentation/provider/product_provider.dart';
import 'package:e_mart_11bdg/presentation/widgets/card.dart';
import 'package:e_mart_11bdg/core/models/kategori.dart';
import 'package:e_mart_11bdg/presentation/pages/cart.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _searchResults = [];
  bool _isSearching = false;

  // contoh rekomendasi kategori
  final List<Kategori> rekomendasi = [
    Kategori(nama: "Fashion", jumlah: 1240),
    Kategori(nama: "Elektronik", jumlah: 980),
    Kategori(nama: "Kecantikan", jumlah: 740),
    Kategori(nama: "Makanan", jumlah: 1120),
    Kategori(nama: "Rumah Tangga", jumlah: 620),
  ];

  void _search(String query) async {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults.clear();
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    final provider = Provider.of<ProductProvider>(context, listen: false);
    await provider.searchProducts(query); // method baru di provider
    setState(() {
      _searchResults = provider.searchResult;
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFBF3131),
        title: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Cari Produk...",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: const TextStyle(color: Colors.white),
          onChanged: _search,
        ),
      ),
      body:
          _controller.text.isEmpty
              ? _buildRekomendasi()
              : _isSearching
              ? const Center(child: CircularProgressIndicator())
              : _buildHasil(screenWidth, screenHeight),
    );
  }

  Widget _buildRekomendasi() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          "Rekomendasi Kategori",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children:
              rekomendasi
                  .map(
                    (kat) => Chip(
                      label: Text("${kat.nama} (${kat.jumlah})"),
                      backgroundColor: Colors.red.shade100,
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }

  Widget _buildHasil(double screenWidth, double screenHeight) {
    if (_searchResults.isEmpty) {
      return const Center(
        child: Text(
          "⚠️ Produk tidak ditemukan",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: _searchResults.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: screenWidth / (screenHeight / 1.83),
      ),
      itemBuilder: (context, index) {
        final product = _searchResults[index];
        return ProductCard(
          imageUrl:
              product['foto_cover'] ??
              ((product['foto'] is List && product['foto'].isNotEmpty)
                  ? product['foto'][0]['foto']
                  : ''),
          title: product['nama_product'] ?? '',
          price: "Rp ${product['harga'] ?? '0'}",
          sold: (product['sold'] ?? product['stock'] ?? 0).toString(),
          seller:
              (product['user']?['toko']?['nama_toko']) ??
              (product['user']?['name']) ??
              'Toko',
          rating: double.tryParse(product['average_rating'].toString()) ?? 0.0,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CartPage()),
            );
          },
        );
      },
    );
  }
}
