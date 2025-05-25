import 'package:flutter/material.dart';
import 'package:e_mart_11bdg/presentation/pages/payment.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> cartItems = [
    CartItem(
      title: 'Makaroni Keju Sultan ',
      description: 'Large, Coklat',
      price: 25000,
      imageUrl: 'https://img-global.cpcdn.com/recipes/df9a4018d168b654/680x482cq70/macaroni-saus-spaghetti-foto-resep-utama.jpg',
      selected: false,
    ),
    CartItem(
      title: 'TWS Galaxy Buds 3',
      description: 'Silver, Wireless Charging',
      price: 189999,
      imageUrl: 'https://via.placeholder.com/100',
      selected: false,
    ),
  ];

  void toggleSelection(int index, bool? selected) {
    setState(() {
      cartItems[index].selected = selected ?? false;
    });
  }

  int get selectedCount =>
      cartItems.where((item) => item.selected).length;

  int get totalPrice => cartItems
      .where((item) => item.selected)
      .fold(0, (sum, item) => sum + item.price);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Keranjang',
          style: const TextStyle(
            fontFamily: 'Righteous',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.008,
                    horizontal: screenWidth * 0.03,
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          activeColor: Colors.red,
                          value: item.selected,
                          onChanged: (value) =>
                              toggleSelection(index, value),
                        ),
                        SizedBox(
                          width: screenWidth * 0.22,
                          height: screenWidth * 0.22,
                          child: Image.network(item.imageUrl),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(
                                  fontFamily: 'Righteous',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                item.description,
                                style: const TextStyle(
                                  fontFamily: 'Righteous',
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Rp ${item.price}',
                                style: const TextStyle(
                                  fontFamily: 'Righteous',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            width: screenWidth,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.02,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade300),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$selectedCount produk dipilih',
                      style: const TextStyle(
                        fontFamily: 'Righteous',
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Subtotal: Rp $totalPrice',
                      style: const TextStyle(
                        fontFamily: 'Righteous',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: screenHeight * 0.015,
                  ),
                ),
                child: Text(
                  'Checkout',
                  style: TextStyle(
                    fontFamily: 'Righteous',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem {
  final String title;
  final String description;
  final int price;
  final String imageUrl;
  bool selected;

  CartItem({
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.selected = false,
  });
}
