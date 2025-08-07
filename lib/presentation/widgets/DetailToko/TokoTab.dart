import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_mart_11bdg/presentation/pages/view.dart';
import 'package:e_mart_11bdg/presentation/widgets/card.dart';

class TokoTab extends StatefulWidget {
  @override
  _TokoTabState createState() => _TokoTabState();
}

class _TokoTabState extends State<TokoTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 250, 250, 250),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(112, 110, 110, 110),
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Tambahkan Foto Banner',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 145, 21, 21),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 250, 250, 250),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(112, 110, 110, 110),
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Tambahkan Foto Banner',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 145, 21, 21),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
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
            childAspectRatio:
                MediaQuery.of(context).size.width /
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
                    MaterialPageRoute(builder: (context) => ViewPage()),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}