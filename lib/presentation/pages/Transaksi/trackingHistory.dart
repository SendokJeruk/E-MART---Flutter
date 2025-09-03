import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/Transaksi/trackingStep.dart';

class TrackingPage extends StatelessWidget {
  const TrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = context.watch<TrackingProvider>().steps;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFBF3131),
        foregroundColor: Colors.white,
        title: const Text(
          "Lacak Pengiriman",
          style: TextStyle(
            fontFamily: 'Righteous',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Estimasi
          Container(
            padding: const EdgeInsets.all(16),
            decoration: _boxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "| Pesanan Tiba Pada 5 Juli",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Righteous',
                    color: Colors.red,
                  ),
                ),
                const Divider(color: Colors.red),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    _StepItem(label: "Sedang Dikirim", active: true),
                    _StepItem(label: "Menuju Alamat", active: true),
                    _StepItem(label: "Pesanan Tiba", active: true),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Detail pesanan
          Container(
            padding: const EdgeInsets.all(16),
            decoration: _boxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "Rincian Pesanan",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "SPX Standard",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                        Text("xxxxxxxxxxxxxxxxxxxxx"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Timeline pakai provider
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: _boxDecoration(),
            child: Column(
              children: [
                for (int i = 0; i < steps.length; i++)
                  _TimelineTile(
                    time: steps[i].time,
                    desc: steps[i].desc,
                    active: steps[i].active,
                    plate: steps[i].plate,
                    isLast: i == steps.length - 1,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}

// Step item (atas)
class _StepItem extends StatelessWidget {
  final String label;
  final bool active;

  const _StepItem({required this.label, required this.active});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 8,
          backgroundColor: active ? Colors.red : Colors.grey,
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: active ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }
}

// Timeline item (bawah)
class _TimelineTile extends StatelessWidget {
  final String time;
  final String desc;
  final bool active;
  final String? plate;
  final bool isLast;

  const _TimelineTile({
    required this.time,
    required this.desc,
    required this.active,
    this.plate,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Circle marker + line
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              margin: const EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: active ? Colors.red : Colors.grey,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 8),
        // Text content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: active ? Colors.red : Colors.grey,
                  ),
                ),
                Text(
                  desc,
                  style: TextStyle(
                    color: active ? Colors.red : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (plate != null)
          Text(
            "Plat\n$plate",
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}