import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_mart_11bdg/presentation/widgets/bottom_bar.dart';
import 'package:e_mart_11bdg/presentation/provider/productCard_provider.dart';
import 'package:e_mart_11bdg/presentation/widgets/card.dart'; 

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
                          height: 35,
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
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.shopping_cart,
                            color: Color(0xFFBF3131),
                          ),
                          iconSize: 21,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.filter_list,
                            color: Color(0xFFBF3131),
                          ),
                          iconSize: 21,
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
          final trending = productProvider.trendingProducts;

          if (trending.isEmpty) {
            return Center(child: Text('Tidak ada produk trending'));
          }

          return GridView.builder(
            padding: EdgeInsets.all(5),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 2,
              childAspectRatio: 
                  MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.83),
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),  
            itemCount: trending.length,
            itemBuilder: (context, index) {
              final product = trending[index];
              return ProductCard(
                imageUrl: product.imageUrl,
                title: product.title,
                price: product.price,
                sold: product.sold,
                seller: product.seller,
                rating: product.rating,
                onTap: () {
                  // TODO: bisa navigasi ke halaman detail produk
                },
              );
            },
          );
        },
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomBar(currentIndex: 1),
    );
  }
}
