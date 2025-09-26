import 'package:e_mart_11bdg/presentation/pages/Settings/myAccount/accountAddress/myAddress.dart';
import 'package:e_mart_11bdg/presentation/widgets/Payment/tokoSection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_mart_11bdg/presentation/provider/product_provider.dart';
import 'package:e_mart_11bdg/presentation/provider/Address/locationProvider.dart'; // cukup 1
import 'package:e_mart_11bdg/presentation/provider/Address/addressProvider.dart'; // provider address
import '../../widgets/BoxSectionHeader/sectionHeader.dart';
import '../../widgets/BoxSectionHeader/boxContent.dart';
import '../../widgets/Payment/bodyPaymentProduk.dart';

class DetailTransactionPage extends StatefulWidget {
    final List<int> selectedIds;

  const DetailTransactionPage({super.key, required this.selectedIds});

  @override
  State<DetailTransactionPage> createState() => _DetailTransactionPageState();
}

class _DetailTransactionPageState extends State<DetailTransactionPage> {
  String? selectedCourier;

  @override
  Widget buildRow(
    String title,
    String value, {
    bool bold = false,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 13, color: Colors.grey[700])),
          Text(
            value,
            style: TextStyle(
              fontSize: bold ? 16 : 13,
              color: color ?? Colors.grey[700],
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    final lokasiProvider = Provider.of<LocationProvider>(context);
    final addressProvider = Provider.of<AddressProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFBF3131),
        foregroundColor: Colors.white,
        title: const Text(
          "Payment",
          style: TextStyle(
            fontFamily: 'Righteous',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // BOX ALAMAT
            boxContent(
              screenWidth: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionHeader("Pilih Alamat"),
                  const Divider(color: Colors.red),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      final selectedAddress = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MyaddressPage(),
                        ),
                      );
                      if (selectedAddress != null) {
                        lokasiProvider.setManualAddress(selectedAddress);
                      }
                    },
                    child: Container(
                      width: screenWidth * 0.9,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 12),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              lokasiProvider.selectedAddress?['label'] ??
                                  "Pilih Alamat",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                color:
                                    lokasiProvider.selectedAddress == null
                                        ? Colors.grey
                                        : Colors.black,
                              ),
                            ),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // BOX KURIR
            boxContent(
              screenWidth: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionHeader("Detail Produk"),
                  const Divider(color: Colors.red),

                  // --- HEADER TOKO ---
                  TokoSectionWidget(screenWidth: screenWidth),
                  const SizedBox(height: 15),

                  // --- LIST PRODUK DARI TOKO ---
                  Column(
                    children: List.generate(2, (index) {
                      return ProdukPaymentWidget(
                        index: index,
                        screenWidth: screenWidth,
                      );
                    }),
                  ),

                  // --- PILIH KURIR ---
                  GestureDetector(
                    onTap: () async {
                      final courier =
                          await showModalBottomSheet<Map<String, String>>(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) {
                              return ListView(
                                shrinkWrap: true,
                                children:
                                    addressProvider.kurirList.map((kurir) {
                                      return ListTile(
                                        title: Text(kurir['nama']!),
                                        onTap:
                                            () => Navigator.pop(context, kurir),
                                      );
                                    }).toList(),
                              );
                            },
                          );

                      if (courier != null) {
                        setState(() {
                          selectedCourier = courier['kode'];
                        });

                        final selectedAddress = lokasiProvider.selectedAddress;
                        if (selectedAddress != null) {
                          const origin = "501";
                          const weight = 1200;
                          const kodeTransaksi = "TRX123";

                          await addressProvider.getOngkirByAddress(
                            origin: origin,
                            destination: selectedAddress['kode_domestik'],
                            weight: weight,
                            courier: courier['kode']!,
                            kodeTransaksi: kodeTransaksi,
                          );
                        }
                      }
                    },
                    child: Container(
                      width: screenWidth * 0.9,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 12),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              selectedCourier != null
                                  ? addressProvider.kurirList.firstWhere(
                                    (k) => k['kode'] == selectedCourier,
                                  )['nama']!
                                  : "Pilih Kurir",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                color:
                                    selectedCourier == null
                                        ? Colors.grey
                                        : Colors.black,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.local_shipping,
                            color: Color(0xFFBF3131),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            boxContent(
              screenWidth: screenWidth,
              child: Consumer<AddressProvider>(
                builder: (context, addressProvider, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sectionHeader("Rincian Pembayaran"),
                      const SizedBox(height: 30),
                      Column(
                        children: [
                          buildRow("Harga Per Produk", "Rp. 10000"),
                          buildRow("Jumlah Produk", "1000x"),
                          buildRow(
                            "Biaya Layanan",
                            "Rp. ${addressProvider.ongkir}",
                          ),
                          const Divider(height: 30),
                          buildRow(
                            "Subtotal",
                            "Rp. ${10000 + addressProvider.ongkir}",
                            bold: true,
                            color: const Color.fromARGB(255, 109, 20, 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                    ],
                  );
                },
              ),
            ),
   
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
              child: ElevatedButton(
                onPressed: () {
                  debugPrint('Order Ditekan');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBF3131),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text("Order Sekarang",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}