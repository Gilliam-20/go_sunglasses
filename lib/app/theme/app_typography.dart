import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Type system for GO!
///
/// Three roles, used with discipline:
/// - Fraunces (display serif): headlines, editorial statements — the
///   "luxury" voice, given room to breathe.
/// - Archivo Black (kinetic mark): the wordmark, eyebrows, buttons,
///   price tags — the "velocity" voice, always tracked wide.
/// - Jost (body): everything a person actually reads.
///
/// FONTS ARE LOCAL, NOT FETCHED — this project does NOT use the
/// `google_fonts` package (no runtime network calls for type). Instead,
/// each role points at a custom font family name that you register
/// yourself in `pubspec.yaml` + `assets/fonts/`. See
/// `assets/fonts/README.md` for exact download links and file names.
///
/// Until you add those files, these family names simply won't be found
/// and Flutter falls back to the platform default font — the app still
/// runs and looks fine, just without the custom faces. Nothing breaks
/// either way.
class AppTypography {
  AppTypography._();

  static const String _displayFamily = 'Fraunces';
  static const String _kineticFamily = 'ArchivoBlack';
  static const String _bodyFamily = 'Jost';

  // Web-safe fallbacks used only until the real files are installed.
  static const List<String> _serifFallback = ['Georgia', 'Times New Roman', 'serif'];
  static const List<String> _sansFallback = ['Helvetica', 'Arial', 'sans-serif'];

  static TextStyle display({Color color = AppColors.ink, double size = 72}) {
    return TextStyle(
      fontFamily: _displayFamily,
      fontFamilyFallback: _serifFallback,
      fontSize: size,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.italic,
      height: 1.02,
      letterSpacing: -1.2,
      color: color,
    );
  }

  static TextStyle headline({Color color = AppColors.ink, double size = 40}) {
    return TextStyle(
      fontFamily: _displayFamily,
      fontFamilyFallback: _serifFallback,
      fontSize: size,
      fontWeight: FontWeight.w600,
      height: 1.08,
      letterSpacing: -0.5,
      color: color,
    );
  }

  static TextStyle serifBody({Color color = AppColors.ink, double size = 20}) {
    return TextStyle(
      fontFamily: _displayFamily,
      fontFamilyFallback: _serifFallback,
      fontSize: size,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
      height: 1.4,
      color: color,
    );
  }

  static TextStyle kinetic({
    Color color = AppColors.ink,
    double size = 14,
    double spacing = 3,
  }) {
    return TextStyle(
      fontFamily: _kineticFamily,
      fontFamilyFallback: _sansFallback,
      fontSize: size,
      fontWeight: FontWeight.w900,
      letterSpacing: spacing,
      color: color,
    );
  }

  static TextStyle wordmark({Color color = AppColors.ink, double size = 28}) {
    return TextStyle(
      fontFamily: _kineticFamily,
      fontFamilyFallback: _sansFallback,
      fontSize: size,
      fontWeight: FontWeight.w900,
      letterSpacing: 1,
      color: color,
    );
  }

  static TextStyle body({Color color = AppColors.ink, double size = 16}) {
    return TextStyle(
      fontFamily: _bodyFamily,
      fontFamilyFallback: _sansFallback,
      fontSize: size,
      fontWeight: FontWeight.w400,
      height: 1.6,
      color: color,
    );
  }

  static TextStyle bodyMedium({Color color = AppColors.ink, double size = 16}) {
    return TextStyle(
      fontFamily: _bodyFamily,
      fontFamilyFallback: _sansFallback,
      fontSize: size,
      fontWeight: FontWeight.w500,
      height: 1.5,
      color: color,
    );
  }

  static TextStyle caption({Color color = AppColors.steel, double size = 13}) {
    return TextStyle(
      fontFamily: _bodyFamily,
      fontFamilyFallback: _sansFallback,
      fontSize: size,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: color,
    );
  }

  static TextStyle price({Color color = AppColors.ink, double size = 16}) {
    return TextStyle(
      fontFamily: _bodyFamily,
      fontFamilyFallback: _sansFallback,
      fontSize: size,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.3,
      color: color,
    );
  }
}
