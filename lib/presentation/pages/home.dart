import 'package:e_mart_11bdg/data/models/productApi.dart';
import 'package:e_mart_11bdg/presentation/pages/splash.view.dart';
import 'package:e_mart_11bdg/presentation/pages/view.dart';
import 'package:flutter/material.dart';
import 'package:e_mart_11bdg/presentation/widgets/card.dart';
import 'package:e_mart_11bdg/presentation/widgets/skeleton.dart';
import 'package:e_mart_11bdg/presentation/widgets/shimmerSKeleton.dart';
import 'package:e_mart_11bdg/core/errors/imageError.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post>? posts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      resizeToAvoidBottomInset: true,
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
      body: isLoaded
          ? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Column(
                  children: [
                    Container(
                      width: screenWidth * 0.9,
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(12),
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
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hai People 👋',
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Yuk cek produk baru & terbaik hari ini!',
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.9,
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.all(12),
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
                            ),
                          ),
                        ],
                      ),
                    ),
                    GridView.count(
                      crossAxisCount: 2,
                      padding: EdgeInsets.all(5),
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.83),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        ProductCard(
                          imageUrl:
                              'https://img-global.cpcdn.com/recipes/df9a4018d168b654/680x482cq70/macaroni-saus-spaghetti-foto-resep-utama.jpg',
                          title: 'Sneakers Wanita',
                          price: 'Rp 325.000',
                          sold: '500',
                          seller: 'SepatuLaris',
                          rating: 4.6,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : buildHomeShimmer(),
    );
  }
}