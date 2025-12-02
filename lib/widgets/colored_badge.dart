import 'package:flutter/material.dart';

import '../utils/label_colors.dart';

enum BadgeKind { status, documentType }

class ColoredBadge extends StatelessWidget {
  final String label;
  final BadgeKind kind;
  final EdgeInsetsGeometry padding;

  const ColoredBadge({
    super.key,
    required this.label,
    required this.kind,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  });

  @override
  Widget build(BuildContext context) {
    final color = kind == BadgeKind.status
        ? statusColor(label)
        : documentTypeColor(label);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
