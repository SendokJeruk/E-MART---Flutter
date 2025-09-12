import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_mart_11bdg/presentation/provider/Address/addressProvider.dart';
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
    Future.microtask(
      () => context.read<AddressProvider>().loadAddressesFromApi(),
    );
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
                MaterialPageRoute(builder: (_) => const AddAddressPage()),
              );
            },
          ),
        ],
      ),
      body:
          alamatList.isEmpty
              ? const Center(child: CircularProgressIndicator())
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

                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context, alamat);
                    },
                    child: Container(
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
                          ),
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
                              const Icon(
                                Icons.location_on,
                                color: Color(0xFFBF3131),
                                size: 20,
                              ),
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
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  final confirm = await showDialog<bool>(
                                    context: context,
                                    builder:
                                        (_) => AlertDialog(
                                          title: const Text("Hapus Alamat"),
                                          content: const Text(
                                            "Yakin ingin menghapus alamat ini?",
                                          ),
                                          actions: [
                                            TextButton(
                                              child: const Text("Batal"),
                                              onPressed:
                                                  () => Navigator.pop(
                                                    context,
                                                    false,
                                                  ),
                                            ),
                                            TextButton(
                                              child: const Text("Hapus"),
                                              onPressed:
                                                  () => Navigator.pop(
                                                    context,
                                                    true,
                                                  ),
                                            ),
                                          ],
                                        ),
                                  );

                                  if (confirm == true && context.mounted) {
                                    final success = await context
                                        .read<AddressProvider>()
                                        .deleteAddress(alamat['id']);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          success
                                              ? "Alamat berhasil dihapus"
                                              : "Gagal menghapus alamat",
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
