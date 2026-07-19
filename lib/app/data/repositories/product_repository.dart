import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';
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

  List<String> get lookbookSeeds => List.generate(8, (i) => 'go-eyewear-lookbook-${i + 1}');

  // Shared swatch colors, reused across frames the way real color chips do.
  static const _inkBlack = FrameColor(name: 'Ink Black', swatch: AppColors.ink, imageSeed: '');
  static const _chrome = FrameColor(name: 'Chrome', swatch: AppColors.chrome, imageSeed: '');
  static const _gunmetal = FrameColor(name: 'Gunmetal', swatch: Color(0xFF3A3B3C), imageSeed: '');
  static const _tortoise = FrameColor(name: 'Tortoise', swatch: Color(0xFF8B5A2B), imageSeed: '');
  static const _gold = FrameColor(name: 'Gold', swatch: Color(0xFFD4AF37), imageSeed: '');
  static const _bone = FrameColor(name: 'Bone', swatch: AppColors.bone, imageSeed: '');
  static const _signalTip = FrameColor(name: 'Signal Red Tip', swatch: AppColors.signal, imageSeed: '');

  List<FrameColor> _colors(String productId, List<FrameColor> base) {
    return base
        .map((c) => FrameColor(
              name: c.name,
              swatch: c.swatch,
              imageSeed: '$productId-${c.name.toLowerCase().replaceAll(' ', '-').replaceAll('/', '-')}',
            ))
        .toList();
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
          colors: _colors('velocity-aviator', [_chrome, _inkBlack, _gunmetal]),
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
          colors: _colors('signal-aviator', [_gold, _inkBlack]),
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
          colors: _colors('ink-aviator', [_inkBlack, _chrome]),
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
          colors: _colors('motion-round', [_tortoise, _inkBlack]),
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
          colors: _colors('kinetic-round', [_chrome, _bone]),
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
          colors: _colors('ember-round', [_tortoise, _signalTip]),
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
          colors: _colors('velocity-cat-eye', [_inkBlack, _tortoise]),
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
          colors: _colors('signal-cat-eye', [_bone, _inkBlack]),
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
          colors: _colors('motion-cat-eye', [_tortoise, _chrome]),
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
          colors: _colors('steel-rectangle', [_gunmetal, _chrome]),
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
          colors: _colors('ink-rectangle', [_inkBlack, _tortoise]),
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
          colors: _colors('kinetic-rectangle', [_chrome, _inkBlack]),
        ),
      ];
}
