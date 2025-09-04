import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_provider.dart';
import '../widgets/card.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    super.initState();
    // panggil API saat halaman dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Produk'),
      ),
      body: productProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : productProvider.products.isEmpty
              ? Center(child: Text("Tidak ada produk"))
              : GridView.builder(
                  padding: EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 2,
                    childAspectRatio: screenWidth / (screenHeight / 1.83),
                  ),
                  itemCount: productProvider.products.length,
                  itemBuilder: (context, index) {
                  final p = productProvider.products[index];

                  // ambil gambar: prioritas foto_cover, fallback ke foto[0].foto kalau ada
                  final String imageUrl = p['foto_cover'] ??
                      ((p['foto'] is List && (p['foto'] as List).isNotEmpty)
                          ? p['foto'][0]['foto']
                          : '');

                  // nama toko/seller: user.toko.nama_toko -> fallback user.name -> 'Toko'
                  final String seller = (p['user']?['toko']?['nama_toko']) ??
                      (p['user']?['name']) ??
                      'Toko';

                  return ProductCard(
                    imageUrl: imageUrl,
                    title: p['nama_product'] ?? '',
                    price: "Rp ${p['harga']}",                  // jika mau format ribuan, nanti bisa ditambah helper
                    sold: (p['sold'] ?? p['stock'] ?? 0).toString(), // API kamu belum ada 'sold', pakai stock dulu
                    seller: seller,
                    rating: double.tryParse(
                            (p['average_rating'] ?? 0).toString()
                          ) ??
                        0.0,
                    onTap: () {
                      // TODO: navigate ke detail, kirim id
                      // Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(id: p['id'])));
                      },
                    );
                  },
                ),
    );
  }
}
