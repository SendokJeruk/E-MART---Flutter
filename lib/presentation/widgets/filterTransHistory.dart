import 'package:flutter/material.dart';

class FilterBottomSheet {
  static void showDatePickerSheet(BuildContext context, ValueChanged<String> onSelected) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Pilih Tanggal",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    String formatted = "${picked.day}-${picked.month}-${picked.year}";
                    onSelected(formatted);
                    Navigator.pop(context);
                  }
                },
                child: const Text("Buka Date Picker"),
              ),
            ],
          ),
        );
      },
    );
  }

  static void showPaymentSheet(BuildContext context, ValueChanged<String> onSelected) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Pilih Metode Pembayaran",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red, fontFamily: 'Righteous'),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.account_balance_wallet, color: Colors.red),
                title: const Text("BANKING"),
                onTap: () {
                  onSelected("BANKING");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_balance_wallet, color: Colors.red),
                title: const Text("E-MONEY"),
                onTap: () {
                  onSelected("E-MONEY");
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}