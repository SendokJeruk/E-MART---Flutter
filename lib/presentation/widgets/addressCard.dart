import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final String name;
  final String miniAddress;
  final String phone;
  final String fullAddress;

  const AddressCard({
    super.key,
    required this.name,
    required this.miniAddress,
    required this.phone,
    required this.fullAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name + Mini Address
          Text(
            "$name - $miniAddress",
            style: const TextStyle(
              color: Color(0xFFBF3131),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 4),

          // Phone number
          Text(
            phone,
            style: const TextStyle(
              color: Color(0xFFBF3131),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),

          // Address row with icon
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on,
                  color: Color(0xFFBF3131), size: 22),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  fullAddress,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}