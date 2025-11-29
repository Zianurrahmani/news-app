import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardImage extends StatelessWidget {
  final String? url;
  final double width;
  final double height;
  final double borderRadius;

  const CardImage({
    super.key,
    required this.url,
    this.width = 120,
    this.height = 100,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) {
      return _errorIcon();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: FadeInImage.assetNetwork(
        placeholder: '',
        image: url!,
        width: width,
        height: height,
        fit: BoxFit.cover,
        fadeInDuration: const Duration(milliseconds: 400),
        placeholderErrorBuilder: (context, error, stackTrace) => _shimmer(),
        imageErrorBuilder: (context, error, stackTrace) => _errorIcon(),
      ),
    );
  }

  // --- SHIMMER LOADING ---
  Widget _shimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        color: Colors.grey.shade300,
      ),
    );
  }

  // --- ERROR ICON ---
  Widget _errorIcon() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: width,
        height: height,
        color: Colors.grey.shade300,
        child: const Icon(
          Icons.image_not_supported,
          size: 42,
          color: Colors.grey,
        ),
      ),
    );
  }
}
