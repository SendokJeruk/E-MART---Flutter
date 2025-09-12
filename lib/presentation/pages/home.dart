import 'package:e_mart_11bdg/presentation/pages/cart.dart';
import 'package:e_mart_11bdg/presentation/pages/view.dart';
import 'package:e_mart_11bdg/presentation/pages/Payment/payment.dart';
import 'package:e_mart_11bdg/presentation/widgets/bottom_bar.dart';
import 'package:e_mart_11bdg/presentation/widgets/card.dart';
import 'package:e_mart_11bdg/presentation/widgets/shimmerSKeleton.dart';
import 'package:e_mart_11bdg/presentation/widgets/small_box.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:e_mart_11bdg/presentation/provider/product_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // panggil API via provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
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
              child: Row(
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
                  CircleAvatar(
                    radius: 17.5,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(Icons.shopping_cart, color: Color(0xFFBF3131)),
                      iconSize: 21,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => CartPage()),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  CircleAvatar(
                    radius: 17.5,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(Icons.filter_list, color: Color(0xFFBF3131)),
                      iconSize: 21,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => PaymentPage()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: productProvider.isLoading
          ? buildHomeShimmer()
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Column(
                  children: [
                    // Bagian "Mungkin kamu cari?"
                    Container(
                      width: screenWidth * 0.9,
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                        border: Border(
                          top: BorderSide(color: Color(0xFFBF3131), width: 0.8),
                          bottom: BorderSide(color: Color(0xFFBF3131), width: 0.8),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '------| Mungkin kamu cari? |------',
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Righteous',
                              color: Color(0xFFBF3131),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SmallBox(title: 'Pedas', icon: FontAwesomeIcons.fireFlameCurved),
                                        SmallBox(title: 'Manis', icon: FontAwesomeIcons.cookieBite),
                                        SmallBox(title: 'Asin', icon: FontAwesomeIcons.bowlFood),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SmallBox(title: 'Murah', icon: FontAwesomeIcons.tags),
                                        SmallBox(title: '5k', icon: FontAwesomeIcons.wallet),
                                        SmallBox(title: 'Promo', icon: FontAwesomeIcons.gift),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: (screenWidth * 0.1) * 3.6 + 10,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                    border: Border(
                                      left: BorderSide(color: Color(0xFFBF3131), width: 0.8),
                                      right: BorderSide(color: Color(0xFFBF3131), width: 0.8),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Promo Spesial',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Label Cari Makanan Favorit
                    Container(
                      width: screenWidth * 0.6,
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Color(0xFFBF3131),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Yuk Cari Makanan Favorit-mu!',
                            style: TextStyle(
                              fontSize: screenWidth * 0.038,
                              color: Colors.white,
                              fontFamily: 'Righteous',
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Grid Produk API
                    GridView.builder(
                      padding: EdgeInsets.all(5),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: productProvider.products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 2,
                        childAspectRatio: screenWidth / (screenHeight / 1.83),
                      ),
                      itemBuilder: (context, index) {
                        final product = productProvider.products[index];
                      return ProductCard(
                        imageUrl: product['foto_cover'] ??
                            ((product['foto'] is List && product['foto'].isNotEmpty)
                                ? product['foto'][0]['foto']
                                : ''), // ambil foto_cover, fallback foto pertama
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
                    )

                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomBar(currentIndex: 2),
    );
  }
}
