import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

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
    return Semantics(
      image: true,
      label: label,
      sortKey: const OrdinalSortKey(0),
      child: Image.asset(image),
    );
  }
}
