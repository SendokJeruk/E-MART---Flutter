import 'package:e_mart_11bdg/presentation/widgets/product_skeleton.dart';
import 'package:e_mart_11bdg/presentation/widgets/shimmerSKeleton.dart';
import 'package:flutter/material.dart';
import 'package:e_mart_11bdg/presentation/widgets/product.dart';
import 'package:e_mart_11bdg/presentation/widgets/card.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  bool isLoading = true;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45), // custom tinggi
        child: AppBar(
          backgroundColor: const Color(0xFFBF3131),
          foregroundColor: Colors.white,
          title: Text(
            "Detail Produk",
            style: TextStyle(
              fontFamily: 'Righteous',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            isLoading
                ? const ProductSkeleton()
                : const ProductDetail(
                  imageUrl:
                      'https://img-global.cpcdn.com/recipes/df9a4018d168b654/680x482cq70/macaroni-saus-spaghetti-foto-resep-utama.jpg',
                  title: 'Makaroni Sultan Bp Andi & Bu En',
                  price: 'Rp 325.000',
                  sold: '500',
                  seller: 'endi store',
                  rating: 4.6,
                  description:
                      'Rasakan sensasi makaroni premium dengan cita rasa khas rumahan yang menggugah selera! Makaroni Sultan dibuat dari bahan pilihan dengan bumbu rempah yang kaya, cocok untuk segala suasana – dari camilan santai hingga oleh-oleh spesial.',
                ),

            SizedBox(height: 0),
            if (!isLoading)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          print('Keranjang Ditekan');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFBF3131),
                          foregroundColor: const Color.fromARGB(
                            255,
                            255,
                            255,
                            255,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Masukkan Keranjang"),
                      ),
                    ),

                    SizedBox(height: 0),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '|',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),

                    SizedBox(height: 0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          print('Order Ditekan');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFBF3131),
                          foregroundColor: const Color.fromARGB(
                            255,
                            255,
                            255,
                            255,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Order Sekarang"),
                      ),
                    ),
                  ],
                ),
              ),

            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isExpanded ? 'Sembunyikan Ulasan' : 'Tampilkan Ulasan',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFBF3131),
                    ),
                  ),
                  const SizedBox(width: 6,),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: const Color(0xFFBF3131),
                  )
                ],
              ),
            ),
            const SizedBox(height: 9,),
            if(isExpanded)
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                 color: const Color(0xFFF0F0F0),
                 borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '⭐️⭐️⭐️⭐️⭐️',
                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10,),
                  Text(
                  'Produknya enak banget! Cocok buat cemilan keluarga. Kemasannya juga rapi.',
                ),
                ],
              ),
            ),

            SizedBox(height: 1),
            Container(
              width: screenWidth * 1,
              padding: EdgeInsets.all(1),
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFBF3131),
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            SizedBox(height: 1),
            isLoading
                ? buildHomeShimmer()
                : GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(5),
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 2,
                  childAspectRatio:
                      MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.82),
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
                          MaterialPageRoute(builder: (context) => ViewPage()),
                        );
                      },
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
