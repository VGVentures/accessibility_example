import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class ItemCardDescription extends StatelessWidget {
  const ItemCardDescription({
    required this.description,
    required this.label,
    super.key,
  });

  final String description;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      sortKey: const OrdinalSortKey(2),
      label: label,
      child: Text(
        description,
        style: theme.textTheme.bodyMedium,
      ),
    );
  }
}
