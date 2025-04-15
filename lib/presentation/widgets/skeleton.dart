import 'package:flutter/material.dart';

Widget buildHomeSkeleton() {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          skeletonBox(height: 100, radius: 12),
          SizedBox(height: 16),
          skeletonBox(height: 60, radius: 12),
          SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              return skeletonBox(height: 180, radius: 12);
            },
          ),
        ],
      ),
    ),
  );
}

Widget skeletonBox({double height = 100, double radius = 10, Color? color}) {
  return Container(
    width: double.infinity,
    height: height,
    decoration: BoxDecoration(
      color: color ?? Colors.grey[300],
      borderRadius: BorderRadius.circular(radius),
    ),
  );
}