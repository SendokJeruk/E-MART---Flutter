import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_mart_11bdg/data/models/Kategori.dart';
import 'package:e_mart_11bdg/presentation/provider/kategori_provider.dart';

class KategoriTab extends StatefulWidget {
  const KategoriTab({super.key});

  @override
  State<KategoriTab> createState() => _KategoriTabState();
}

class _KategoriTabState extends State<KategoriTab> {
  @override
  void initState() {
    super.initState();
    Provider.of<KategoriProvider>(context, listen: false).fetchKategori();
  }

  @override
  Widget build(BuildContext context) {
    final kategoriList = Provider.of<KategoriProvider>(context).kategoriList;

    return Scaffold(
      backgroundColor: Colors.white,
      body:
          kategoriList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: kategoriList.length,
                itemBuilder: (context, index) {
                  final kategori = kategoriList[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: const EdgeInsets.all(12),
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
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),

                        const SizedBox(width: 8),

                        Container(
                          height: 40, 
                          width: 1.5,
                          color: Colors.red[400],
                        ),

                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            kategori.nama,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Righteous',
                            ),
                          ),
                        ),
                        Text(
                          kategori.jumlah.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontFamily: 'Righteous',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.chevron_right, color: Colors.red[600]),
                      ],
                    ),
                  );
                },
              ),
    );
  }
}
