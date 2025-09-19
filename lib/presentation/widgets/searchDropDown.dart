import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';

class ProductSearchOverlay extends StatefulWidget {
  const ProductSearchOverlay({super.key});

  @override
  State<ProductSearchOverlay> createState() => _ProductSearchOverlayState();
}

class _ProductSearchOverlayState extends State<ProductSearchOverlay> {
  final TextEditingController _searchController = TextEditingController();
  bool _showDropdown = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    return Column(
      children: [
        // 🔍 Input Search
        TextField(
          controller: _searchController,
          onChanged: (value) async {
            if (value.isNotEmpty) {
              setState(() => _showDropdown = true);
              await provider.searchProducts(value);
            } else {
              setState(() => _showDropdown = false);
              provider.clearSearch(); // ✅ reset
            }
          },
          decoration: InputDecoration(
            hintText: "Cari produk...",
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        // 🔽 Dropdown Overlay
        if (_showDropdown)
          Expanded( // ✅ biar layout ga unbounded
            child: Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: provider.searchLoading
                  ? const Center(child: CircularProgressIndicator()) // ✅ loading
                  : provider.searchResult.isEmpty
                      ? const Center(
                          child: Text(
                            "⚠️ Tidak ada barang ditemukan",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: provider.searchResult.length,
                          itemBuilder: (context, index) {
                            final item = provider.searchResult[index];
                            return ListTile(
                              leading: const Icon(Icons.shopping_bag),
                              title: Text(item['nama_product'] ?? "Produk tanpa nama"),
                              subtitle: Text("Rp ${item['harga'] ?? 0}"),
                              onTap: () {
                                // TODO: arahkan ke halaman detail produk
                                setState(() => _showDropdown = false);
                                provider.clearSearch();
                              },
                            );
                          },
                        ),
            ),
          ),
      ],
    );
  }
}

//MASIH PR INI