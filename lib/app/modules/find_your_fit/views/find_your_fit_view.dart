import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/product_model.dart';
import '../../../data/unsplash_photos.dart';
import '../../../global_widgets/go_image.dart';
import '../../../global_widgets/nav_bar.dart';
import '../../../global_widgets/responsive.dart';
import '../../../global_widgets/section_label.dart';
import '../../../global_widgets/site_footer.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';

class FindYourFitView extends StatelessWidget {
  const FindYourFitView({super.key});

  static const _guide = [
    (
      faceShape: 'ROUND',
      photoUrl: UnsplashPhotos.wayfarerFlatlay,
      recommends: FrameShape.rectangle,
      recommendLabel: 'RECTANGLE',
      note: 'Soft, even features benefit from a frame with sharp, '
          'angular lines — it adds definition a round face doesn\'t '
          'have on its own.',
    ),
    (
      faceShape: 'SQUARE',
      photoUrl: UnsplashPhotos.roundOnBlueCircle,
      recommends: FrameShape.round,
      recommendLabel: 'ROUND',
      note: 'A strong jawline reads best against curves. Round frames '
          'soften a square face without fighting its structure.',
    ),
    (
      faceShape: 'OVAL',
      photoUrl: UnsplashPhotos.auroraAviatorSilver,
      recommends: FrameShape.aviator,
      recommendLabel: 'AVIATOR',
      note: 'Balanced proportions mean an oval face carries almost '
          'anything — the aviator\'s double bridge is the house\'s '
          'safest, most versatile pick.',
    ),
    (
      faceShape: 'HEART',
      photoUrl: UnsplashPhotos.catEyeBlueFramed,
      recommends: FrameShape.catEye,
      recommendLabel: 'CAT-EYE',
      note: 'A narrower chin pairs well with a frame that\'s widest at '
          'the top — the cat-eye lift echoes a heart-shaped brow line '
          'instead of competing with it.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final gutter = Responsive.gutter(context);
    final isDesktop = Responsive.isDesktop(context);
    final columns = Responsive.isDesktop(context) ? 2 : 1;

    return Scaffold(
      backgroundColor: AppColors.bone,
      appBar: const NavBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(gutter, 56, gutter, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionLabel(text: 'FIND YOUR FIT'),
                  const SizedBox(height: 16),
                  Text('Shop by\nFace Shape.', style: AppTypography.headline(size: 44)),
                  const SizedBox(height: 14),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Text(
                      'Not sure where to start? Match your face shape to a '
                      'frame the house recommends — or skip straight to '
                      'shopping by shape instead.',
                      style: AppTypography.body(color: AppColors.ink.withOpacity(0.7), size: 15),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gutter, vertical: 24),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _guide.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  mainAxisSpacing: 28,
                  crossAxisSpacing: 28,
                  childAspectRatio: isDesktop ? 1.5 : 1.05,
                ),
                itemBuilder: (context, i) {
                  final g = _guide[i];
                  return _FaceShapeCard(
                    faceShape: g.faceShape,
                    photoUrl: g.photoUrl,
                    recommendLabel: g.recommendLabel,
                    recommends: g.recommends,
                    note: g.note,
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
            const SiteFooter(),
          ],
        ),
      ),
    );
  }
}

class _FaceShapeCard extends StatelessWidget {
  final String faceShape;
  final String photoUrl;
  final String recommendLabel;
  final FrameShape recommends;
  final String note;

  const _FaceShapeCard({
    required this.faceShape,
    required this.photoUrl,
    required this.recommendLabel,
    required this.recommends,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.boneSoft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 4,
            child: GoImage(url: UnsplashPhotos.sized(photoUrl, width: 500, height: 700, grayscale: true)),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(faceShape, style: AppTypography.kinetic(size: 12, color: AppColors.steel)),
                  const SizedBox(height: 10),
                  Text('Try $recommendLabel', style: AppTypography.headline(size: 24)),
                  const SizedBox(height: 12),
                  Text(note, style: AppTypography.body(size: 13, color: AppColors.ink.withOpacity(0.7))),
                  const SizedBox(height: 18),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.collection, arguments: recommends),
                    child: Text(
                      'SHOP $recommendLabel →',
                      style: AppTypography.kinetic(size: 11, color: AppColors.signal, spacing: 1.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
