import 'package:e_mart_11bdg/presentation/pages/view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_mart_11bdg/presentation/provider/product_provider.dart';
import 'package:e_mart_11bdg/presentation/widgets/card.dart';
import 'package:e_mart_11bdg/presentation/pages/cart.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  void _search(String query) {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    if (query.isEmpty) {
      provider.clearSearch();
    } else {
      provider.searchProductsByNamaProduct(query);
    }
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
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          if (_controller.text.isEmpty) {
            return const Center(
              child: Text(
                "🔎 Ketik untuk mencari produk...",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          if (provider.searchLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return _buildHasil(screenWidth, screenHeight, provider.searchResult);
        },
      ),
    );
  }

  Widget _buildHasil(
    double screenWidth,
    double screenHeight,
    List<dynamic> results,
  ) {
    if (results.isEmpty) {
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
      itemCount: results.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: screenWidth / (screenHeight / 1.83),
      ),
      itemBuilder: (context, index) {
        final product = results[index];

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
              MaterialPageRoute(
                builder: (_) => ViewPage(product: product), 
              ),
            );
          },
        );
      },
    );
  }
}
