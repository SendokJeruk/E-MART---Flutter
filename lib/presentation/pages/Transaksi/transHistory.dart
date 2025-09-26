import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../pages/Transaksi/detailTransaksi.dart';
import '../../provider/Transaksi/transaction_history.dart';
import '../../widgets/filterTransHistory.dart';

class TransHistory extends StatefulWidget {
  const TransHistory({super.key});

  @override
  State<TransHistory> createState() => _TransHistoryState();
}

Widget sectionHeader(
  String title, {
  required VoidCallback onTap,
  String? subtitle,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(8),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title kiri
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Righteous',
              color: Colors.red,
            ),
          ),

          // Subtitle + chevron kanan
          Row(
            children: [
              if (subtitle != null)
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              const SizedBox(width: 5),
              const Icon(Icons.chevron_right, color: Colors.red),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildFilterButton(
  BuildContext context,
  String label,
  int index,
  int selectedIndex,
) {
  final provider = Provider.of<TransHistoryProvider>(context, listen: false);
  final isSelected = selectedIndex == index;

  return GestureDetector(
    onTap: () => provider.setFilter(index),
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 6,
      ), // diperkecil
      decoration: BoxDecoration(
        color: isSelected ? Colors.red : Colors.white,
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: isSelected ? Colors.white : Colors.red,
        ),
      ),
    ),
  );
}

class _TransHistoryState extends State<TransHistory> {
  bool showDatePickerInline = false;
  bool showPaymentInline = false;

  String selectedDate = "Pilih Tanggal";
  String selectedPayment = "Pilih Metode";
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransHistoryProvider>(context);
    final transaction = provider.transactions;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFBF3131),
        foregroundColor: Colors.white,
        title: const Text(
          "Riwayat Transaksi",
          style: TextStyle(
            fontFamily: 'Righteous',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                sectionHeader(
                  "Tanggal",
                  subtitle: provider.selectedDate,
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (picked != null) {
                      String formatted =
                          "${picked.day.toString().padLeft(2, '0')}-"
                          "${picked.month.toString().padLeft(2, '0')}-"
                          "${picked.year}";
                      provider.setSelectedDate(formatted);
                    }
                  },
                ),

                const SizedBox(height: 12),

                // Section Metode Pembayaran
                sectionHeader(
                  "Metode Pembayaran",
                  subtitle: provider.selectedPayment,
                  onTap: () {
                    FilterBottomSheet.showPaymentSheet(context, (value) {
                      provider.setSelectedPayment(value);
                    });
                  },
                ),
                // const Divider(),
                const SizedBox(height: 12),
                // Filter Tabs
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterButton(
                        context,
                        "Semua",
                        0,
                        provider.selectedFilter,
                      ),
                      const SizedBox(width: 6),
                      // _buildFilterButton(context, "Pembayaran", 1, provider.selectedFilter),
                      // const SizedBox(width: 6),
                      _buildFilterButton(
                        context,
                        "Lainnya",
                        2,
                        provider.selectedFilter,
                      ),
                      const SizedBox(width: 6),
                      _buildFilterButton(
                        context,
                        "E-Money",
                        3,
                        provider.selectedFilter,
                      ),
                      const SizedBox(width: 6),
                      _buildFilterButton(
                        context,
                        "Gagal",
                        4,
                        provider.selectedFilter,
                      ),
                      const SizedBox(width: 6),
                      _buildFilterButton(
                        context,
                        "Berhasil",
                        5,
                        provider.selectedFilter,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 3),

          // Header Bulan
          Container(
            width: double.infinity,
            color: const Color(0xFFBF3131),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: const Text(
              "Juli 2025",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Righteous',
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // List transaksi
          ...transaction.map((t) {
            return Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailTransaksiPage(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Kiri (icon + detail)
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    t["title"],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Text(
                                    t["subtitle"],
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    t["date"],
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Kanan (nominal + status)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Rp ${t["amount"]}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            t["status"],
                            style: TextStyle(
                              color:
                                  t["status"] == "Berhasil"
                                      ? Colors.green
                                      : Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
