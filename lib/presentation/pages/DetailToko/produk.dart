import 'package:flutter/material.dart';
import 'package:e_mart_11bdg/presentation/pages/payment.dart';
import 'package:e_mart_11bdg/presentation/pages/cart.dart';
import 'package:e_mart_11bdg/presentation/provider/tab_provider.dart';
import 'package:provider/provider.dart';
import 'package:e_mart_11bdg/presentation/widgets/DetailToko/KategoriTab.dart';
import 'package:e_mart_11bdg/presentation/widgets/DetailToko/TokoTab.dart';
import 'package:e_mart_11bdg/presentation/widgets/DetailToko/ProdukTab.dart';

class ProdukDetailPerson extends StatefulWidget {
  const ProdukDetailPerson({super.key});

  @override
  State<ProdukDetailPerson> createState() => _ProdukDetailPersonState();
}

class _ProdukDetailPersonState extends State<ProdukDetailPerson> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CartPage(),
                              ),
                            );
                          },
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentPage(),
                              ),
                            );
                          },
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: null,
                ),
              ),
              SizedBox(width: 12),

              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Store SS',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Righteous',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 100),
                          child: Text(
                            'Follow +',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Righteous',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      '3,3k Followers',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Righteous',
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '5.0',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.star, color: Colors.amber, size: 16),

                        SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 20),
          Container(
            width: screenWidth * 1,
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          
          SizedBox(height: 20),
          Consumer<TabProvider>(
            builder: (context, tabProvider, _) {
              final tabs = ['Produk', 'Toko', 'Kategori'];

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                      tabs.asMap().entries.map((entry) {
                        final index = entry.key;
                        final label = entry.value;
                        final isSelected = tabProvider.selectedIndex == index;

                        return GestureDetector(
                          onTap: () {
                            Provider.of<TabProvider>(
                              context,
                              listen: false,
                            ).changeTab(index);
                          },
                          child: Row(
                            children: [
                              Text(
                                label,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Righteous',
                                  color: isSelected ? Colors.red : Colors.black,
                                ),
                              ),
                              if (index != tabs.length - 1)
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                  child: Text(
                                    '|',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Righteous',
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      }).toList(),
                ),
              );
            },
          ),

          SizedBox(height: 20),
          Container(
            width: screenWidth * 1,
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          const SizedBox(height: 20),
          Expanded(
            
            child: Consumer<TabProvider>(
              builder: (context, tabProvider, _) {
                switch (tabProvider.selectedIndex) {
                  case 0:
                    return ProdukTab(); 
                  case 1:
                    return TokoTab(); 
                  case 2:
                    return KategoriTab();
                  default:
                    return SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
