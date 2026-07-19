import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Three short diagonal strokes of decreasing length — a graphic shorthand
/// for velocity, used sparingly as a section marker instead of a plain
/// horizontal rule.
class SpeedLines extends StatelessWidget {
  final Color color;
  final double height;
  const SpeedLines({super.key, this.color = AppColors.steel, this.height = 20});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: height,
      child: CustomPaint(
        painter: _SpeedLinesPainter(color: color),
      ),
    );
  }
}

class _SpeedLinesPainter extends CustomPainter {
  final Color color;
  _SpeedLinesPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final lengths = [size.width, size.width * 0.62, size.width * 0.32];
    for (var i = 0; i < lengths.length; i++) {
      final y = size.height * 0.2 + i * (size.height * 0.4);
      canvas.drawLine(
        Offset(0, y + 6),
        Offset(lengths[i], y),
        paint..color = color.withOpacity(1.0 - i * 0.28),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
