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
/// own photo so the product image updates when a shopper taps a
/// different color, the way every eyewear PDP on the market works.
class FrameColor {
  final String name;
  final Color swatch;

  /// Base Unsplash CDN URL for this colorway's photo (no query params —
  /// sizing/crop/grayscale are applied by `ProductModel.imageUrl`). See
  /// `UnsplashPhotos` for the source registry.
  final String photoBaseUrl;

  const FrameColor({required this.name, required this.swatch, required this.photoBaseUrl});
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

  /// Builds a sized/cropped image URL from an Unsplash base CDN URL.
  /// images.unsplash.com serves through an Imgix-compatible pipeline, so
  /// width/height/crop/format/grayscale are all controlled via query
  /// params — no download or re-hosting needed.
  String imageUrl(String baseUrl, {int width = 900, int height = 1100, bool grayscale = false}) {
    final sat = grayscale ? '&sat=-100' : '';
    return '$baseUrl?auto=format&fit=crop&w=$width&h=$height&q=80$sat';
  }

  String get coverImage => imageUrl(colors.first.photoBaseUrl);

  String imageForColor(int colorIndex) => imageUrl(colors[colorIndex].photoBaseUrl);
}
