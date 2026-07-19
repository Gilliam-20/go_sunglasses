import 'package:flutter/material.dart';

/// Sunglasses are shopped by shape first — this mirrors how real eyewear
/// sites (Ray-Ban, Sunglass Hut, Warby Parker) structure navigation and
/// filtering, since shape is the single attribute shoppers care about most.
enum FrameShape { aviator, round, catEye, rectangle }

extension FrameShapeLabel on FrameShape {
  String get label {
    switch (this) {
      case FrameShape.aviator:
        return 'AVIATOR';
      case FrameShape.round:
        return 'ROUND';
      case FrameShape.catEye:
        return 'CAT-EYE';
      case FrameShape.rectangle:
        return 'RECTANGLE';
    }
  }
}

/// A single colorway of a frame — swatch color for the picker, plus its
/// own photo seed so the product image updates when a shopper taps a
/// different color, the way every eyewear PDP on the market works.
class FrameColor {
  final String name;
  final Color swatch;
  final String imageSeed;

  const FrameColor({required this.name, required this.swatch, required this.imageSeed});
}

class ProductModel {
  final String id;
  final String name;
  final String material;
  final double price;
  final FrameShape shape;
  final String description;
  final List<FrameColor> colors;
  final List<String> lensOptions;
  final List<String> frameWidths;

  const ProductModel({
    required this.id,
    required this.name,
    required this.material,
    required this.price,
    required this.shape,
    required this.description,
    required this.colors,
    this.lensOptions = const ['Polarized', 'Standard'],
    this.frameWidths = const ['Narrow', 'Standard', 'Wide'],
  });

  String get formattedPrice => '\$${price.toStringAsFixed(0)}';

  /// A stable, royalty-free network image URL derived from a seed.
  /// Swap these for real product photography before launch — see README.
  String imageUrl(String seed, {int width = 900, int height = 1100, bool grayscale = false}) {
    final gs = grayscale ? '?grayscale' : '';
    return 'https://picsum.photos/seed/$seed/$width/$height$gs';
  }

  String get coverImage => imageUrl(colors.first.imageSeed);

  String imageForColor(int colorIndex) => imageUrl(colors[colorIndex].imageSeed);
}
