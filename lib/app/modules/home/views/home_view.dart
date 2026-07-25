import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/product_model.dart';
import '../../../data/unsplash_photos.dart';
import '../../../global_widgets/diagonal_clipper.dart';
import '../../../global_widgets/go_button.dart';
import '../../../global_widgets/go_image.dart';
import '../../../global_widgets/nav_bar.dart';
import '../../../global_widgets/product_card.dart';
import '../../../global_widgets/responsive.dart';
import '../../../global_widgets/section_label.dart';
import '../../../global_widgets/site_footer.dart';
import '../../../global_widgets/velocity_ticker.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bone,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: controller.scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Hero(),
                const VelocityTicker(
                  words: [
                    'UV400',
                    'POLARIZED',
                    'GO!',
                    'NO STANDING STILL',
                    'GO!',
                  ],
                ),
                _Manifesto(),
                _ShapeGrid(),
                _LensTech(),
                _Featured(),
                _EditorialTeaser(),
                const SiteFooter(),
              ],
            ),
          ),
          Obx(
            () => AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              child: NavBar(
                transparent: !controller.solidNav.value,
                light: !controller.solidNav.value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Hero extends StatefulWidget {
  @override
  State<_Hero> createState() => _HeroState();
}

class _HeroState extends State<_Hero> with SingleTickerProviderStateMixin {
  late final AnimationController _anim;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final isMobile = Responsive.isMobile(context);
    final gutter = Responsive.gutter(context);
    final fade = CurvedAnimation(parent: _anim, curve: Curves.easeOutCubic);

    return ClipPath(
      clipper: const DiagonalBottomClipper(dropFraction: 0.045),
      child: SizedBox(
        height: (isMobile ? h * 0.94 : h).clamp(620.0, 980.0).toDouble(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            GoImage(
              url: UnsplashPhotos.sized(
                HomeController.heroImageUrl,
                width: 1800,
                height: 1400,
                grayscale: true,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    AppColors.ink.withOpacity(0.86),
                    AppColors.ink.withOpacity(0.35),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gutter),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeTransition(
                    opacity: fade,
                    child: const SectionLabel(
                      text: 'GO! EYEWEAR — SS26',
                      color: AppColors.bone,
                    ),
                  ),
                  const SizedBox(height: 22),
                  FadeTransition(
                    opacity: fade,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.08),
                        end: Offset.zero,
                      ).animate(fade),
                      child: Text(
                        'MOVEMENT\nIS THE ONLY\nLUXURY.',
                        style: AppTypography.display(
                          color: AppColors.bone,
                          size: isMobile ? 44 : 92,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  FadeTransition(
                    opacity: fade,
                    child: SizedBox(
                      width: isMobile ? double.infinity : 460,
                      child: Text(
                        'GO! designs for people who don\'t stand still — frames '
                        'and lenses cut with the balance and clarity to move as '
                        'fast as you do.',
                        style: AppTypography.body(
                          color: AppColors.chrome,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  FadeTransition(
                    opacity: fade,
                    child: GoButton(
                      label: 'SHOP THE COLLECTION',
                      light: true,
                      onPressed: () => Get.toNamed(Routes.collection),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Manifesto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final gutter = Responsive.gutter(context);

    final textContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SectionLabel(text: 'THE HOUSE'),
        const SizedBox(height: 20),
        Text(
          'Built for people who\ndon\'t stand still.',
          style: AppTypography.headline(size: isDesktop ? 44 : 30),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: isDesktop ? 460 : double.infinity,
          child: Text(
            'GO! was founded on a simple refusal: that luxury has to mean '
            'stillness. Every frame in this house is drafted first for '
            'motion, then for form — the fit is only finished once it holds '
            'up at a full stride.',
            style: AppTypography.serifBody(
              color: AppColors.ink.withOpacity(0.75),
              size: 18,
            ),
          ),
        ),
        const SizedBox(height: 28),
        GoButton(
          label: 'READ THE MANIFESTO',
          style: GoButtonStyle.outline,
          onPressed: () => Get.toNamed(Routes.about),
        ),
      ],
    );

    final imageContent = ClipPath(
      clipper: const DiagonalTopClipper(dropFraction: 0.06),
      child: AspectRatio(
        aspectRatio: 4 / 5,
        child: GoImage(
          url: UnsplashPhotos.sized(
            UnsplashPhotos.onWoodenTable,
            width: 900,
            height: 1100,
          ),
        ),
      ),
    );

    return Container(
      color: AppColors.bone,
      padding: EdgeInsets.symmetric(horizontal: gutter, vertical: 96),
      child:
          isDesktop
              ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 6, child: textContent),
                  const SizedBox(width: 64),
                  Expanded(flex: 5, child: imageContent),
                ],
              )
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textContent,
                  const SizedBox(height: 48),
                  imageContent,
                ],
              ),
    );
  }
}

class _ShapeGrid extends StatelessWidget {
  static const _shapes = [
    (
      label: 'AVIATOR',
      photoUrl: UnsplashPhotos.auroraAviatorGold,
      shape: FrameShape.aviator,
    ),
    (
      label: 'ROUND',
      photoUrl: UnsplashPhotos.roundOrangeMotion,
      shape: FrameShape.round,
    ),
    (
      label: 'CAT-EYE',
      photoUrl: UnsplashPhotos.catEyeBlueFramed,
      shape: FrameShape.catEye,
    ),
    (
      label: 'RECTANGLE',
      photoUrl: UnsplashPhotos.sunglassesInBox,
      shape: FrameShape.rectangle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final gutter = Responsive.gutter(context);
    final columns =
        Responsive.isDesktop(context)
            ? 4
            : (Responsive.isTablet(context) ? 2 : 2);

    return Container(
      color: AppColors.bone,
      padding: EdgeInsets.fromLTRB(gutter, 8, gutter, 96),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionLabel(text: 'SHOP BY SHAPE'),
          const SizedBox(height: 32),
          GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 12),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _shapes.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              childAspectRatio: columns == 4 ? 0.82 : 0.95,
            ),
            itemBuilder: (context, i) {
              final s = _shapes[i];
              return _ShapeTile(
                label: s.label,
                photoUrl: s.photoUrl,
                shape: s.shape,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ShapeTile extends StatefulWidget {
  final String label;
  final String photoUrl;
  final FrameShape shape;
  const _ShapeTile({
    required this.label,
    required this.photoUrl,
    required this.shape,
  });

  @override
  State<_ShapeTile> createState() => _ShapeTileState();
}

class _ShapeTileState extends State<_ShapeTile> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Get.toNamed(Routes.collection, arguments: widget.shape),
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedScale(
              scale: _hovering ? 1.06 : 1.0,
              duration: const Duration(milliseconds: 320),
              child: GoImage(
                url: UnsplashPhotos.sized(
                  widget.photoUrl,
                  width: 700,
                  height: 900,
                  grayscale: true,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [AppColors.ink.withOpacity(0.6), Colors.transparent],
                ),
              ),
            ),
            Positioned(
              left: 18,
              bottom: 18,
              right: 18,
              child: Row(
                children: [
                  Text(
                    widget.label,
                    style: AppTypography.wordmark(
                      color: AppColors.bone,
                      size: 18,
                    ),
                  ),
                  const Spacer(),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    transform: Matrix4.translationValues(
                      _hovering ? 6 : 0,
                      0,
                      0,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: AppColors.bone,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LensTech extends StatelessWidget {
  static const _points = [
    (
      title: 'UV400 PROTECTION',
      body:
          'Every lens blocks 100% of UVA and UVB rays — tested, not '
          'just tinted.',
    ),
    (
      title: 'POLARIZED CLARITY',
      body:
          'Cuts glare off water, glass, and asphalt without dulling '
          'true color.',
    ),
    (
      title: 'SCRATCH-RESISTANT COAT',
      body:
          'A hard coat on every lens, so the frame ages faster than '
          'the glass does.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final gutter = Responsive.gutter(context);
    final isDesktop = Responsive.isDesktop(context);

    final blocks =
        _points
            .map(
              (p) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 32, height: 3, color: AppColors.signal),
                  const SizedBox(height: 18),
                  Text(
                    p.title,
                    style: AppTypography.kinetic(
                      color: AppColors.bone,
                      size: 13,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    p.body,
                    style: AppTypography.body(color: AppColors.chrome),
                  ),
                ],
              ),
            )
            .toList();

    return Container(
      color: AppColors.ink,
      padding: EdgeInsets.symmetric(horizontal: gutter, vertical: 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionLabel(text: 'LENS TECHNOLOGY', color: AppColors.bone),
          const SizedBox(height: 40),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  blocks
                      .map(
                        (b) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: b,
                          ),
                        ),
                      )
                      .toList(),
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  blocks
                      .map(
                        (b) => Padding(
                          padding: const EdgeInsets.only(bottom: 32),
                          child: b,
                        ),
                      )
                      .toList(),
            ),
        ],
      ),
    );
  }
}

class _Featured extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final gutter = Responsive.gutter(context);
    final columns = Responsive.gridColumns(context);
    final products = controller.featured;

    return Container(
      color: AppColors.boneSoft,
      padding: EdgeInsets.symmetric(horizontal: gutter, vertical: 96),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionLabel(text: 'NEW ARRIVALS'),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: Text(
                  'This Season\'s Frames',
                  style: AppTypography.headline(size: 36),
                ),
              ),
              if (Responsive.isDesktop(context))
                GoButton(
                  label: 'VIEW FULL COLLECTION',
                  style: GoButtonStyle.outline,
                  onPressed: () => Get.toNamed(Routes.collection),
                ),
            ],
          ),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              mainAxisSpacing: 40,
              crossAxisSpacing: 28,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (context, i) => ProductCard(product: products[i]),
          ),
          if (!Responsive.isDesktop(context)) ...[
            const SizedBox(height: 32),
            Center(
              child: GoButton(
                label: 'VIEW FULL COLLECTION',
                style: GoButtonStyle.outline,
                onPressed: () => Get.toNamed(Routes.collection),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _EditorialTeaser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gutter = Responsive.gutter(context);
    final isDesktop = Responsive.isDesktop(context);

    return ClipPath(
      clipper: const DiagonalTopClipper(dropFraction: 0.03),
      child: Container(
        color: AppColors.ink,
        height: isDesktop ? 560 : 640,
        child: Stack(
          fit: StackFit.expand,
          children: [
            GoImage(
              url: UnsplashPhotos.sized(
                HomeController.editorialImageUrl,
                width: 1600,
                height: 1000,
                grayscale: true,
              ),
            ),
            Container(color: AppColors.ink.withOpacity(0.55)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gutter),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionLabel(
                    text: 'SS26 EDITORIAL',
                    color: AppColors.bone,
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'THE LOOKBOOK',
                    style: AppTypography.display(
                      color: AppColors.bone,
                      size: isDesktop ? 64 : 40,
                    ),
                  ),
                  const SizedBox(height: 28),
                  GoButton(
                    label: 'VIEW THE LOOKBOOK',
                    light: true,
                    onPressed: () => Get.toNamed(Routes.lookbook),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
