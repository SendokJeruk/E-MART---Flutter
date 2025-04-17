import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductSkeleton extends StatelessWidget {
  const ProductSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 200, width: double.infinity, color: Colors.white),
          const SizedBox(height: 16),
          Container(height: 20, width: 150, color: Colors.white),
          const SizedBox(height: 8),
          Container(height: 20, width: 100, color: Colors.white),
          const SizedBox(height: 8),
          Container(height: 20, width: 200, color: Colors.white),
          const SizedBox(height: 16),
          Container(height: 100, width: double.infinity, color: Colors.white),
        ],
      ),
    );
  }
}