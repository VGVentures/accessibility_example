import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class ItemCardTitle extends StatelessWidget {
  const ItemCardTitle({
    required this.title,
    required this.label,
    super.key,
  });

  final String title;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      sortKey: const OrdinalSortKey(1),
      header: true,
      child: Text(
        title,
        style: theme.textTheme.titleLarge,
      ),
    );
  }
}
