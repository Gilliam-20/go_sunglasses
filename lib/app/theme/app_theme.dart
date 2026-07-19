import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.bone,
      fontFamily: AppTypography.body().fontFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.signal,
        brightness: Brightness.light,
        primary: AppColors.signal,
        surface: AppColors.bone,
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      dividerColor: AppColors.divider,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.signal,
        selectionColor: AppColors.signal,
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: MaterialStateProperty.all(AppColors.steel.withOpacity(0.4)),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
    );
  }
}
