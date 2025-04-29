import 'package:flutter/material.dart';

class ErrorImageHandler extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;

  const ErrorImageHandler({
    super.key,
    required this.imageUrl,
    this.width = 100,
    this.height = 100,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          alignment: Alignment.center,
          child: Icon(Icons.broken_image, color: Colors.grey[700], size: width * 0.4),
        );
      },
    );
  }
}

// ⬇️ FUNGSI GLOBAL DI LUAR CLASS
Widget buildNetworkImageWithFallback({
  required String imageUrl,
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
}) {
  return Image.network(
    imageUrl,
    width: width,
    height: height,
    fit: fit,
    errorBuilder: (context, error, stackTrace) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey.shade200,
        alignment: Alignment.center,
        child: const Icon(
          Icons.broken_image,
          color: Colors.grey,
          size: 40,
        ),
      );
    },
  );
}