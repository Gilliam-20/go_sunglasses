import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'go_mark.dart';

/// A continuously scrolling strip of brand words, separated by the GO!
/// bullet mark. Used as a thin band between major sections — motion made
/// literal, in a place a static divider would normally go.
class VelocityTicker extends StatefulWidget {
  final List<String> words;
  final Color background;
  final Color foreground;
  final Duration duration;

  const VelocityTicker({
    super.key,
    this.words = const ['VELOCITY', 'PRECISION', 'GO!', 'NO STANDING STILL', 'GO!'],
    this.background = AppColors.signal,
    this.foreground = AppColors.bone,
    this.duration = const Duration(seconds: 14),
  });

  @override
  State<VelocityTicker> createState() => _VelocityTickerState();
}

class _VelocityTickerState extends State<VelocityTicker> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final row = Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.words.length * 4, (i) {
        final word = widget.words[i % widget.words.length];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(word, style: AppTypography.kinetic(color: widget.foreground, size: 16)),
              const SizedBox(width: 22),
              GoBullet(scale: 0.8, color: widget.foreground),
            ],
          ),
        );
      }),
    );

    return Container(
      color: widget.background,
      height: 56,
      width: double.infinity,
      child: ClipRect(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return OverflowBox(
                  maxWidth: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Transform.translate(
                    offset: Offset(-_controller.value * 1400, 0),
                    child: row,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
