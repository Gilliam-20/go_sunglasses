import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

enum GoButtonStyle { solid, outline, ghost }

/// A button whose only micro-interaction is a small forward nudge on
/// hover — a literal "go" gesture rather than a generic scale-up.
class GoButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final GoButtonStyle style;
  final bool light;
  final double horizontalPadding;

  const GoButton({
    super.key,
    required this.label,
    this.onPressed,
    this.style = GoButtonStyle.solid,
    this.light = false,
    this.horizontalPadding = 32,
  });

  @override
  State<GoButton> createState() => _GoButtonState();
}

class _GoButtonState extends State<GoButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final bg = switch (widget.style) {
      GoButtonStyle.solid => widget.light ? AppColors.bone : AppColors.ink,
      GoButtonStyle.outline => Colors.transparent,
      GoButtonStyle.ghost => Colors.transparent,
    };
    final fg = switch (widget.style) {
      GoButtonStyle.solid => widget.light ? AppColors.ink : AppColors.bone,
      GoButtonStyle.outline => widget.light ? AppColors.bone : AppColors.ink,
      GoButtonStyle.ghost => widget.light ? AppColors.bone : AppColors.ink,
    };
    final border = widget.style == GoButtonStyle.outline
        ? Border.all(color: fg, width: 1.2)
        : null;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(_hovering ? 6 : 0, 0, 0),
          padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding, vertical: 18),
          decoration: BoxDecoration(color: bg, border: border),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.label, style: AppTypography.kinetic(color: fg, size: 13)),
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: _hovering ? 18 : 10,
                margin: const EdgeInsets.only(left: 12),
                child: Icon(Icons.arrow_forward, size: 16, color: fg),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
