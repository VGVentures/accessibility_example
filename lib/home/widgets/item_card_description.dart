import 'package:flutter/material.dart';

class ItemCardDescription extends StatelessWidget {
  const ItemCardDescription({
    required this.description,
    super.key,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        description,
        semanticsLabel: description,
        textScaleFactor: textScaleFactor * 1,
      ),
    );
  }
}
