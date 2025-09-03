import 'package:flutter/material.dart';
import '../../../data/models/Tracking.dart';

class TrackingProvider with ChangeNotifier {
  final List<TrackingStep> _steps = [
    TrackingStep(
      time: "5 Jun - 11.21",
      desc: "Pesanan tiba di alamat tujuan.\nLihat Bukti Pengiriman",
      active: true,
      plate: "D4836VFm",
    ),
    TrackingStep(
      time: "5 Jun - 10.21",
      desc: "Pesanan dalam proses pengantaran",
      plate: "D4836VFm",
    ),
    TrackingStep(
      time: "5 Jun - 10.10",
      desc: "Kurir ditugaskan mengambil pesanan",
      plate: "D4836VFm",
    ),
    TrackingStep(
      time: "5 Jun - 10.08",
      desc:
          "Pengirim telah mengatur jadwal pengiriman.\nMenunggu pesanan diserahkan ke pihak jasa kirim.",
    ),
    TrackingStep(
      time: "4 Jun - 21.38",
      desc: "Pesanan dibuat.",
    ),
  ];

  List<TrackingStep> get steps => _steps;
}