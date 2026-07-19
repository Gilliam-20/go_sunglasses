import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// The GO! wordmark.
///
/// The brand's whole visual signature lives in this one glyph: the "!"
/// is never typed, it's drawn — a hairline bar and a dot, both in Signal
/// Red, slightly separated as if the mark is still moving. This same
/// bar-and-dot form recurs as a divider and bullet throughout the site.
class GoMark extends StatelessWidget {
  final double size;
  final Color color;
  final bool light;

  const GoMark({super.key, this.size = 28, this.color = AppColors.ink, this.light = false});

  @override
  Widget build(BuildContext context) {
    final textColor = light ? AppColors.bone : color;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('GO', style: AppTypography.wordmark(color: textColor, size: size)),
        SizedBox(width: size * 0.12),
        _ExclamationGlyph(size: size),
      ],
    );
  }
}

class _ExclamationGlyph extends StatelessWidget {
  final double size;
  const _ExclamationGlyph({required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 0.22,
      height: size * 0.78,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: size * 0.16,
            height: size * 0.48,
            decoration: BoxDecoration(
              color: AppColors.signal,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Container(
            width: size * 0.16,
            height: size * 0.16,
            decoration: const BoxDecoration(
              color: AppColors.signal,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}

/// The bar-and-dot form used standalone as a divider or bullet.
class GoBullet extends StatelessWidget {
  final double scale;
  final Color color;
  const GoBullet({super.key, this.scale = 1, this.color = AppColors.signal});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 6 * scale,
      height: 22 * scale,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(width: 4 * scale, height: 14 * scale, color: color),
          Container(
            width: 4 * scale,
            height: 4 * scale,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }
}
