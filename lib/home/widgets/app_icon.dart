import 'package:flutter/material.dart';

/// {@template app_icon}
/// A reusable [Icon] that scales with the current font size.
/// {@endtemplate}
class AppIcon extends StatelessWidget {
  /// {@macro app_icon}
  const AppIcon({
    required this.icon,
    required this.fontSize,
    required this.label,
    super.key,
  });

  /// The icon to display.
  final IconData icon;

  /// The size of the current font.
  final double fontSize;

  /// final label
  final String label;

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.textScalerOf(context);

    return Icon(
      icon,
      semanticLabel: label,
      size: textScaleFactor.scale(fontSize) * 1.5,
    );
  }
}
