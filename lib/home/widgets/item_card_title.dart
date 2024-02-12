import 'package:flutter/material.dart';

class ItemCardTitle extends StatelessWidget {
  const ItemCardTitle({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        semanticsLabel: title,
      ),
    );
  }
}
