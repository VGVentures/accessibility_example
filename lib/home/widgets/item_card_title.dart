import 'package:flutter/material.dart';

class ItemCardTitle extends StatelessWidget {
  const ItemCardTitle({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        title,
        semanticsLabel: title,
        textScaleFactor: textScaleFactor * 1.5,
      ),
    );
  }
}
