import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_mart_11bdg/presentation/widgets/bottom_bar.dart';
import 'package:e_mart_11bdg/presentation/provider/product_provider.dart';
import 'package:e_mart_11bdg/presentation/widgets/card.dart'; 
import 'package:e_mart_11bdg/presentation/pages/view.dart';

class TrendingPage extends StatefulWidget {
  const TrendingPage({super.key});

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,

      // APPBAR
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Color(0xFFBF3131),
          iconTheme: const IconThemeData(color: Colors.white),
          flexibleSpace: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: screenWidth * 0.09,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.grey),
                              SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Cari Produk',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Container(
                        height: screenWidth * 0.09,
                        width: screenWidth * 0.09,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                            icon: Icon(
                              Icons.shopping_cart, color: Color(0xFFBF3131)
                              ),
                              iconSize: screenWidth * 0.05, 
                              onPressed: () {},
                          ),
                        ),
                      SizedBox(width: screenWidth * 0.02),
                      Container(
                        height: screenWidth * 0.09,
                        width: screenWidth * 0.09,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.filter_list,
                            color: Color(0xFFBF3131),
                            ),
                            iconSize: screenWidth * 0.05,
                            onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      backgroundColor: Colors.white,

      body: Consumer<ProductProvider>(
        builder: (context, productProvider, _) {
          final trending = productProvider.products;

          if (trending.isEmpty) {
            return Center(child: Text('Tidak ada produk trending'));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GridView.builder(
                padding: EdgeInsets.all(5),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: trending.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 2,
                  childAspectRatio: screenWidth / (screenHeight / 1.83),
                ),
                itemBuilder: (context, index) {
                  final product = trending[index];
                return ProductCard(
                  imageUrl: product['foto_cover'] ??
                      ((product['foto'] is List && product['foto'].isNotEmpty)
                          ? product['foto'][0]['foto']
                          : ''),
                  title: product['nama_product'] ?? '',
                  price: "Rp ${product['harga'] ?? '0'}",
                  sold: (product['sold'] ?? product['stock'] ?? 0).toString(),
                  seller: (product['user']?['toko']?['nama_toko']) ??
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
              ),
            ),
          );
        },
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomBar(currentIndex: 1),
    );
  }
}
