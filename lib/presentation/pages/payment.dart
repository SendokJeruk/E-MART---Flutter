import 'package:flutter/material.dart';
import 'package:e_mart_11bdg/presentation/widgets/bottom_bar.dart';
import 'package:e_mart_11bdg/presentation/pages/PaymentMethod.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPage();
}

class _PaymentPage extends State<PaymentPage> {
  String? selectedPaymentMethod;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: AppBar(
          backgroundColor: const Color(0xFFBF3131),
          foregroundColor: Colors.white,
          title: Text(
            "Payment",
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
            Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.21,
              padding: EdgeInsets.all(15),
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
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Nama Penjual",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFBF3131),
                      fontFamily: 'Righteous',
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 9,
                              offset: Offset(2,0)
                            )
                          ]
                        ),
                        child: ClipRRect(
                        borderRadius: BorderRadius.circular(9),
                        child: Image.network(
                          'https://img-global.cpcdn.com/recipes/df9a4018d168b654/680x482cq70/macaroni-saus-spaghetti-foto-resep-utama.jpg',
                          // height: 100,
                          // width: 100,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              // height: 100,
                              // width: 100,
                              color: Colors.grey.shade200,
                              child: Center(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value:
                                        loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                              (loadingProgress.expectedTotalBytes ?? 1)
                                            : null,
                                  ),
                                ),
                              ),
                            );
                          },
                          errorBuilder: (contecxt, error, stackTree) {
                            return Container(
                              height: 100,
                              width: 100,
                              color: Colors.grey.shade300,
                              child: Center(
                                child: Icon(
                                  Icons.broken_image,
                                  color: Colors.grey,
                                  size: 40,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                  Text(
                                    "Nama Produk",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFBF3131),
                                      fontFamily: 'Righteous',
                                    ),
                                  ),
                          
                                  Text(
                                    "Rp. 100.000",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFBF3131),
                                      fontFamily: 'Righteous',
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Jumlah Barang",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        "5x",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
  //BATAS
                Container(
              width: screenWidth * 1,
              padding: EdgeInsets.all(1),
              margin: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Color(0xFFBF3131),
                borderRadius: BorderRadius.circular(12),
              ),
            ),

  //BATAS
            Container(
                width: screenWidth * 0.9,
              height: screenHeight * 0.3,
              padding: EdgeInsets.all(15),
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
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Rincian Pembayaran",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFBF3131),
                      fontFamily: 'Righteous',
                    ),
                  ),
                  SizedBox(height: 40),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Text(
                            "Harga Per Produk",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "Rp. 100.000",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                       Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Text(
                            "Jumlah Produk",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "5x",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                       Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Text(
                            "Biaya Layanan",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "Rp. 5.000",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      const Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 20),
                      
                       Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Text(
                            "Subtotal",
                            style: TextStyle(
                              fontSize: 16,
                              color: const Color.fromARGB(255, 109, 20, 20),
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "Rp. 505.000",
                            style: TextStyle(
                              fontSize: 16,
                              color: const Color.fromARGB(255, 109, 20, 20),
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  )
                ],
              ),
            ),


  //BATAS   
             Container(
                width: screenWidth * 0.9,
              height: screenHeight * 0.15,
              padding: EdgeInsets.all(15),
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
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Metode Pembayaran",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFBF3131),
                      fontFamily: 'Righteous',
                    ),
                  ),
                  SizedBox(height: 10),

                ],
              ),
            ),

            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 22, vertical: 22),
              child: ElevatedButton(
                onPressed: () {
                  print('Order Ditekan');
                },
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFBF3131),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text("Order Sekarang",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold 
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
