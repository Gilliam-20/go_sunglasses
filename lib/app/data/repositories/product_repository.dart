import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';
import '../unsplash_photos.dart';
import '../../theme/app_colors.dart';

/// Data source for the GO! Eyewear catalog.
///
/// Registered as a GetxService (not a GetxController) because it is an
/// app-wide resource with no lifecycle tied to any single screen — every
/// module (home, collection, product detail, bag) reads from the same
/// instance. In a production build, swap the in-memory list below for a
/// Firestore or REST call and keep this same public interface.
class ProductRepository extends GetxService {
  static ProductRepository get to => Get.find<ProductRepository>();

  late final List<ProductModel> _catalog;

  Future<ProductRepository> init() async {
    _catalog = _buildCatalog();
    return this;
  }

  List<ProductModel> all() => _catalog;

  List<ProductModel> byShape(FrameShape shape) =>
      _catalog.where((p) => p.shape == shape).toList();

  List<ProductModel> featured({int count = 4}) => _catalog.take(count).toList();

  ProductModel byId(String id) => _catalog.firstWhere((p) => p.id == id);

  /// Lookbook rotates through the full licensed photo pool for variety.
  List<String> get lookbookSeeds => UnsplashPhotos.all;

  // Shared swatch colors, reused across frames the way real color chips do.
  static const _inkBlack = Color(0xFF0D0D0D);
  static const _chrome = Color(0xFFC9C9C2);
  static const _gunmetal = Color(0xFF3A3B3C);
  static const _tortoise = Color(0xFF8B5A2B);
  static const _gold = Color(0xFFD4AF37);
  static const _bone = Color(0xFFF2EEE6);
  static const _signal = AppColors.signal;

  /// Every colorway of a given product points at the SAME licensed stock
  /// photo — free stock photography isn't shot per-SKU-per-color, so
  /// this is an honest placeholder. Swap in real per-color product
  /// photography before launch (see README.md).
  List<FrameColor> _colors(String photoUrl, List<({String name, Color swatch})> base) {
    return base.map((c) => FrameColor(name: c.name, swatch: c.swatch, photoBaseUrl: photoUrl)).toList();
  }

  List<ProductModel> _buildCatalog() => [
        // AVIATOR
        ProductModel(
          id: 'velocity-aviator',
          name: 'Velocity Aviator',
          material: 'Double-bridge titanium, polarized glass lens',
          price: 260,
          shape: FrameShape.aviator,
          description:
              'A double-bridge titanium aviator, weighted for balance so it '
              'doesn\'t slide when you move. Polarized glass cuts glare '
              'without dulling color.',
          colors: _colors(UnsplashPhotos.auroraAviatorGold, [
            (name: 'Chrome', swatch: _chrome),
            (name: 'Ink Black', swatch: _inkBlack),
            (name: 'Gunmetal', swatch: _gunmetal),
          ]),
        ),
        ProductModel(
          id: 'signal-aviator',
          name: 'Signal Aviator',
          material: 'Stainless steel frame, gradient lens',
          price: 240,
          shape: FrameShape.aviator,
          description:
              'The house aviator, cut narrower through the brow than most. '
              'A gradient lens fades from ink to clear — dark enough for '
              'noon, light enough for everywhere after.',
          colors: _colors(UnsplashPhotos.auroraAviatorSilver, [
            (name: 'Gold', swatch: _gold),
            (name: 'Ink Black', swatch: _inkBlack),
          ]),
        ),
        ProductModel(
          id: 'ink-aviator',
          name: 'Ink Aviator',
          material: 'Lightweight steel, mirrored lens',
          price: 220,
          shape: FrameShape.aviator,
          description:
              'A featherweight steel build with a flat mirrored lens — '
              'the aviator built for a full day of motion, not a photo op.',
          colors: _colors(UnsplashPhotos.auroraAviatorGold, [
            (name: 'Ink Black', swatch: _inkBlack),
            (name: 'Chrome', swatch: _chrome),
          ]),
        ),

        // ROUND
        ProductModel(
          id: 'motion-round',
          name: 'Motion Round',
          material: 'Hand-finished acetate, glass lens',
          price: 210,
          shape: FrameShape.round,
          description:
              'A true circle in hand-finished acetate, ground thin at the '
              'temple so it never feels heavy. The quiet piece that makes '
              'everything else look intentional.',
          colors: _colors(UnsplashPhotos.roundOrangeMotion, [
            (name: 'Tortoise', swatch: _tortoise),
            (name: 'Ink Black', swatch: _inkBlack),
          ]),
        ),
        ProductModel(
          id: 'kinetic-round',
          name: 'Kinetic Round',
          material: 'Titanium frame, polarized lens',
          price: 195,
          shape: FrameShape.round,
          description:
              'The round shape rebuilt in titanium instead of acetate — '
              'a third of the weight, none of the fragility, polarized '
              'against glare off water and glass.',
          colors: _colors(UnsplashPhotos.roundOnBlueCircle, [
            (name: 'Chrome', swatch: _chrome),
            (name: 'Bone', swatch: _bone),
          ]),
        ),
        ProductModel(
          id: 'ember-round',
          name: 'Ember Round',
          material: 'Acetate frame, gradient lens',
          price: 225,
          shape: FrameShape.round,
          description:
              'Tortoise acetate with a single Signal Red tip at the temple '
              '— the brand mark, worn quietly. Gradient lens, warm at '
              'the base.',
          colors: _colors(UnsplashPhotos.roundOnBlueCircle, [
            (name: 'Tortoise', swatch: _tortoise),
            (name: 'Signal Red Tip', swatch: _signal),
          ]),
        ),

        // CAT-EYE
        ProductModel(
          id: 'velocity-cat-eye',
          name: 'Velocity Cat-Eye',
          material: 'Acetate frame, polarized lens',
          price: 230,
          shape: FrameShape.catEye,
          description:
              'A cat-eye with a sharper lift than most — drafted the same '
              'way we draft a blazer shoulder, structured but never stiff.',
          colors: _colors(UnsplashPhotos.catEyeBlueFramed, [
            (name: 'Ink Black', swatch: _inkBlack),
            (name: 'Tortoise', swatch: _tortoise),
          ]),
        ),
        ProductModel(
          id: 'signal-cat-eye',
          name: 'Signal Cat-Eye',
          material: 'Acetate with metal accent, gradient lens',
          price: 245,
          shape: FrameShape.catEye,
          description:
              'A fine metal browline sits over an acetate base, catching '
              'light the way the Signal Bag\'s stitch does — a small, '
              'considered flash of hardware.',
          colors: _colors(UnsplashPhotos.catEyeBlueFramed, [
            (name: 'Bone', swatch: _bone),
            (name: 'Ink Black', swatch: _inkBlack),
          ]),
        ),
        ProductModel(
          id: 'motion-cat-eye',
          name: 'Motion Cat-Eye',
          material: 'Lightweight acetate, standard lens',
          price: 215,
          shape: FrameShape.catEye,
          description:
              'The everyday cat-eye — lightweight acetate, a gentler lift, '
              'built to live in a bag and come out looking pressed anyway.',
          colors: _colors(UnsplashPhotos.catEyeBlueFramed, [
            (name: 'Tortoise', swatch: _tortoise),
            (name: 'Chrome', swatch: _chrome),
          ]),
        ),

        // RECTANGLE
        ProductModel(
          id: 'steel-rectangle',
          name: 'Steel Rectangle',
          material: 'Titanium frame, polarized lens',
          price: 250,
          shape: FrameShape.rectangle,
          description:
              'A clean rectangle in brushed titanium — the same restraint '
              'as the Steel Suit, cut close and finished without excess.',
          colors: _colors(UnsplashPhotos.sunglassesInBox, [
            (name: 'Gunmetal', swatch: _gunmetal),
            (name: 'Chrome', swatch: _chrome),
          ]),
        ),
        ProductModel(
          id: 'ink-rectangle',
          name: 'Ink Rectangle',
          material: 'Acetate frame, standard lens',
          price: 200,
          shape: FrameShape.rectangle,
          description:
              'A wide rectangular acetate frame with a low bridge — built '
              'for a face that wants coverage without bulk.',
          colors: _colors(UnsplashPhotos.wayfarerFlatlay, [
            (name: 'Ink Black', swatch: _inkBlack),
            (name: 'Tortoise', swatch: _tortoise),
          ]),
        ),
        ProductModel(
          id: 'kinetic-rectangle',
          name: 'Kinetic Rectangle',
          material: 'Titanium frame, gradient lens',
          price: 235,
          shape: FrameShape.rectangle,
          description:
              'Slightly softened corners keep this rectangle from reading '
              'severe. Titanium hinges are rated for motion, not just '
              'display-case stillness.',
          colors: _colors(UnsplashPhotos.sunglassesInBox, [
            (name: 'Chrome', swatch: _chrome),
            (name: 'Ink Black', swatch: _inkBlack),
          ]),
        ),
      ];
}
