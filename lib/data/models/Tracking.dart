import 'package:flutter/material.dart';

class TrackingStep {
  final String time;
  final String desc;
  final bool active;
  final String? plate;

  const TrackingStep({
    required this.time,
    required this.desc,
    this.active = false,
    this.plate,
  });
}