import 'package:flutter/material.dart';

/// GO! brand palette.
///
/// The brand is built around velocity, not old-money quiet luxury —
/// so the palette pairs a stark ink/bone editorial base with a single
/// kinetic accent: Signal Red, the color of the brand's "!" mark.
class AppColors {
  AppColors._();

  // Base
  static const Color ink = Color(0xFF0D0D0D);
  static const Color inkSoft = Color(0xFF1A1A18);
  static const Color bone = Color(0xFFF2EEE6);
  static const Color boneSoft = Color(0xFFE9E3D6);

  // Accent
  static const Color signal = Color(0xFFE8412C);
  static const Color signalDark = Color(0xFFB92F1D);

  // Neutrals
  static const Color steel = Color(0xFF8B8B85);
  static const Color steelLight = Color(0xFFB9B7AE);
  static const Color chrome = Color(0xFFC9C9C2);

  // Semantic
  static const Color divider = Color(0x1F0D0D0D);
  static const Color dividerOnDark = Color(0x1FF2EEE6);
  static const Color success = Color(0xFF3E6B4F);
}
