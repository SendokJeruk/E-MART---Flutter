import 'package:flutter/material.dart';
import 'package:e_mart_11bdg/presentation/provider/addressProvider.dart';
import 'package:provider/provider.dart';
import 'package:e_mart_11bdg/presentation/pages/Settings/myAccount/accountAddress/addAddress.dart';

class MyaddressPage extends StatefulWidget {
  const MyaddressPage({super.key});

  @override
  State<MyaddressPage> createState() => _MyaddressPageState();
}

class _MyaddressPageState extends State<MyaddressPage> {
  @override
  void initState() {
    super.initState();
    // panggil provider saat halaman dibuka
    Future.microtask(() =>
        context.read<AddressProvider>().loadAddressesFromApi());
  }

  @override
  Widget build(BuildContext context) {
    final alamatList = context.watch<AddressProvider>().addressList;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFBF3131),
        foregroundColor: Colors.white,
        title: const Text(
          "Alamat Saya",
          style: TextStyle(
            fontFamily: 'Righteous',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Tambah Alamat',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddAddressPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: alamatList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(), // loading indicator
            )
          : ListView.builder(
              itemCount: alamatList.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final alamat = alamatList[index];

                final prov = alamat['province_name'] ?? '';
                final city = alamat['city_name'] ?? '';
                final dist = alamat['district_name'] ?? '';
                final subd = alamat['subdistrict_name'] ?? '';
                final zip = alamat['zip_code'] ?? '';
                final detail = alamat['detail_alamat'] ?? '';

                final fullAddress =
                    "$subd, $dist, $city, $prov${zip.isNotEmpty ? " ($zip)" : ""}"
                    "${detail.isNotEmpty ? "\nDetail: $detail" : ""}";

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alamat['label'] ?? 'Alamat',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFFBF3131),
                          fontFamily: 'Righteous',
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on,
                              color: Color(0xFFBF3131), size: 20),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              fullAddress,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}