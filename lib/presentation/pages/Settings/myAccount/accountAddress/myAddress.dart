import 'package:flutter/material.dart';
import 'package:e_mart_11bdg/presentation/provider/addressProvider.dart';
import 'package:provider/provider.dart';
import 'package:e_mart_11bdg/presentation/pages/Settings/myAccount/accountAddress/addAddress.dart';

class MyaddressPage extends StatelessWidget {
  const MyaddressPage({super.key});

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
                  builder: (_) => AddAddressPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: alamatList.isEmpty
          ? ListView(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    "Daftar alamat Anda akan ditampilkan di sini.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: alamatList.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final alamat = alamatList[index];
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
                      // Nama + Mini Address + Primary
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "${alamat['name']} - ${alamat['miniAddress']}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFFBF3131),
                                fontFamily: 'Righteous',
                              ),
                            ),
                          ),
                          if (alamat['isPrimary'] == 'true')
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xFFBF3131), width: 1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                "[Primary]",
                                style: TextStyle(
                                  color: Color(0xFFBF3131),
                                  fontFamily: 'Righteous',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Nomor HP
                      Text(
                        alamat['phone'] ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFFBF3131),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Icon lokasi + alamat lengkap
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on,
                              color: Color(0xFFBF3131), size: 20),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              alamat['fullAddress'] ?? '',
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