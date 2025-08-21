import 'package:flutter/material.dart';
import 'package:e_mart_11bdg/presentation/widgets/card.dart';
import 'package:e_mart_11bdg/presentation/pages/view.dart'; // Untuk navigasi ke ViewPage()

class ProdukTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(5),
        crossAxisSpacing: 1,
        mainAxisSpacing: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 1.83),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(10, (index) {
          return ProductCard(
            imageUrl:
                'https://img-global.cpcdn.com/recipes/df9a4018d168b654/680x482cq70/macaroni-saus-spaghetti-foto-resep-utama.jpg',
            title: 'Makaroni Keju Sultan ',
            price: 'Rp 325.000',
            sold: '500',
            seller: 'SepatuLaris',
            rating: 4.6,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProdukTab(),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}