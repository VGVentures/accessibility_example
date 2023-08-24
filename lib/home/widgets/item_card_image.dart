import 'package:flutter/material.dart';

class ItemCardImage extends StatelessWidget {
  const ItemCardImage({
    required this.image,
    required this.label,
    super.key,
  });

  final String image;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      fit: BoxFit.fill,
      semanticLabel: label,
    );
  }
}
