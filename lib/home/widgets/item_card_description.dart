import 'package:flutter/material.dart';

class ItemCardDescription extends StatelessWidget {
  const ItemCardDescription({
    required this.description,
    super.key,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        description,
        style: theme.textTheme.bodyMedium,
        semanticsLabel: description,
      ),
    );
  }
}
