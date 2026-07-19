import 'package:flutter/material.dart';

/// Clips the bottom edge of a section into a shallow diagonal — the
/// "speed cut" that recurs at every major section boundary on the site,
/// standing in for the motion implied by the brand name.
class DiagonalBottomClipper extends CustomClipper<Path> {
  final double dropFraction;
  const DiagonalBottomClipper({this.dropFraction = 0.04});

  @override
  Path getClip(Size size) {
    final drop = size.height * dropFraction;
    final path = Path();
    path.lineTo(0, size.height - drop);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class DiagonalTopClipper extends CustomClipper<Path> {
  final double dropFraction;
  const DiagonalTopClipper({this.dropFraction = 0.04});

  @override
  Path getClip(Size size) {
    final drop = size.height * dropFraction;
    final path = Path();
    path.moveTo(0, drop);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
