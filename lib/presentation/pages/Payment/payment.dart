import 'package:e_mart_11bdg/presentation/pages/Settings/myAccount/accountAddress/MyAddress.dart';
import 'package:e_mart_11bdg/presentation/pages/paymentMethod.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_mart_11bdg/presentation/provider/product_provider.dart';
import 'package:e_mart_11bdg/presentation/provider/Address/locationProvider.dart'; // cukup 1
import 'package:e_mart_11bdg/presentation/provider/Address/addressProvider.dart'; // provider address

class PaymentPage extends StatefulWidget {
  final List<int> selectedIds;

  const PaymentPage({super.key, required this.selectedIds});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedPaymentMethod;
  String? selectedCourier;

  Widget buildRow(String title, String value,
      {bool bold = false, Color? color}) {
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

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
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
            // === PRODUK CARD (contoh static) ===
            Container(
              width: screenWidth * 0.9,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 9)],
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: Image.network(
                        'https://img-global.cpcdn.com/recipes/df9a4018d168b654/680x482cq70/macaroni-saus-spaghetti-foto-resep-utama.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Nama Produk",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Righteous',
                              color: Color(0xFFBF3131),
                            )),
                        Text("Rp. 10000",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFBF3131),
                              fontFamily: 'Righteous',
                            )),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Jumlah Barang",
                                style: TextStyle(fontSize: 13, color: Colors.grey)),
                            Text("1000",
                                style: TextStyle(fontSize: 13, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // === ALAMAT + KURIR ===
            Container(
              width: screenWidth * 0.9,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Alamat Pengiriman",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFBF3131),
                        fontFamily: 'Righteous',
                      )),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      final selectedAddress = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const MyaddressPage()),
                      );
                      if (selectedAddress != null) {
                        lokasiProvider.setManualAddress(selectedAddress);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              lokasiProvider.selectedAddress?['label'] ?? "Pilih Alamat",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                color: lokasiProvider.selectedAddress == null
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
                  const SizedBox(height: 16),
                  const Text("Kurir Pengiriman",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () async {
                      final courier =
                          await showModalBottomSheet<Map<String, String>>(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) {
                          return ListView(
                            shrinkWrap: true,
                            children: addressProvider.kurirList.map((kurir) {
                              return ListTile(
                                title: Text(kurir['nama']!),
                                onTap: () => Navigator.pop(context, kurir),
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
                          const origin = "501"; // kode toko contoh
                          const weight = 1200; // contoh
                          const kodeTransaksi = "TRX123"; // contoh

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
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              selectedCourier != null
                                  ? addressProvider.kurirList.firstWhere(
                                      (k) => k['kode'] == selectedCourier)['nama']!
                                  : "Pilih Kurir",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                color: selectedCourier == null
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                          ),
                          const Icon(Icons.local_shipping, color: Color(0xFFBF3131)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // === RINCIAN PEMBAYARAN ===
            Container(
              width: screenWidth * 0.9,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Consumer<AddressProvider>(
                builder: (context, addressProvider, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Rincian Pembayaran",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFBF3131),
                            fontFamily: 'Righteous',
                          )),
                      const SizedBox(height: 30),
                      Column(
                        children: [
                          buildRow("Harga Per Produk", "Rp. 10000"),
                          buildRow("Jumlah Produk", "1000x"),
                          buildRow("Biaya Layanan", "Rp. ${addressProvider.ongkir}"),
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

                      // === METODE PEMBAYARAN ===
                      const Text("Metode Pembayaran",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFBF3131),
                            fontFamily: 'Righteous',
                          )),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () async {
                          final result = await showModalBottomSheet<String>(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            builder: (context) => Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: const Text('Tunai'),
                                    onTap: () => Navigator.pop(context, 'Tunai'),
                                  ),
                                  ListTile(
                                    title: const Text('Transfer'),
                                    onTap: () async {
                                      final result = await Navigator.push<String>(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => const PaymentMethod()),
                                      );
                                      Navigator.pop(context);
                                      setState(() {
                                        selectedPaymentMethod = result ?? 'Transfer';
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );

                          if (result != null) {
                            setState(() {
                              selectedPaymentMethod = result;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedPaymentMethod ?? "Pilih Metode Pembayaran",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: selectedPaymentMethod == null
                                      ? Colors.grey
                                      : Colors.black,
                                ),
                              ),
                              if (selectedPaymentMethod != null)
                                const Icon(Icons.chevron_right,
                                    color: Color(0xFFBF3131), size: 28),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // === BUTTON ORDER ===
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