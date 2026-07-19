import 'package:flutter/material.dart';

class Responsive {
  Responsive._();

  static const double mobileMax = 700;
  static const double tabletMax = 1100;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileMax;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= mobileMax && w < tabletMax;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletMax;

  /// Horizontal page padding that grows with viewport width.
  static double gutter(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < mobileMax) return 20;
    if (w < tabletMax) return 48;
    if (w < 1500) return 80;
    return (w - 1500) / 2 + 80;
  }

  static int gridColumns(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < mobileMax) return 2;
    if (w < tabletMax) return 3;
    return 4;
  }

  static double maxContentWidth(BuildContext context) => 1600;
}
