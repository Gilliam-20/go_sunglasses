import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'go_mark.dart';

/// A small kinetic-face eyebrow used above section headlines, e.g.
/// "! THE COLLECTION" — the bullet stands in for the brand's "!" mark.
class SectionLabel extends StatelessWidget {
  final String text;
  final Color color;
  const SectionLabel({super.key, required this.text, this.color = AppColors.ink});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GoBullet(scale: 0.9, color: AppColors.signal),
        const SizedBox(width: 10),
        Text(text, style: AppTypography.kinetic(color: color)),
      ],
    );
  }
}
