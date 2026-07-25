import 'package:flutter/material.dart';
import '../../../data/unsplash_photos.dart';
import '../../../global_widgets/diagonal_clipper.dart';
import '../../../global_widgets/go_image.dart';
import '../../../global_widgets/nav_bar.dart';
import '../../../global_widgets/responsive.dart';
import '../../../global_widgets/section_label.dart';
import '../../../global_widgets/site_footer.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';

class _ValueBlock extends StatelessWidget {
  final String title;
  final String body;
  const _ValueBlock({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 32, height: 3, color: AppColors.signal),
        const SizedBox(height: 18),
        Text(title, style: AppTypography.kinetic(size: 14)),
        const SizedBox(height: 12),
        Text(body, style: AppTypography.body(color: AppColors.ink.withOpacity(0.7))),
      ],
    );
  }
}

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  static const _values = [
    (
      title: 'MOTION FIRST',
      body: 'Every frame is tested while walking, not standing at a mirror — '
          'balance is only approved once it holds at a full stride.',
    ),
    (
      title: 'HONEST MATERIAL',
      body: 'Titanium and acetate sourced for how they hold up, not just '
          'how they photograph on a display stand.',
    ),
    (
      title: 'ONE ACCENT',
      body: 'Signal Red appears once per frame, never more — '
          'restraint is the house\'s only rule.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final gutter = Responsive.gutter(context);
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      backgroundColor: AppColors.bone,
      appBar: const NavBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipPath(
              clipper: const DiagonalBottomClipper(dropFraction: 0.05),
              child: SizedBox(
                height: isDesktop ? 560 : 460,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    GoImage(url: UnsplashPhotos.sized(UnsplashPhotos.bwPortraitWithHat, width: 1600, height: 1000, grayscale: true)),
                    Container(color: AppColors.ink.withOpacity(0.6)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: gutter),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionLabel(text: 'THE MANIFESTO', color: AppColors.bone),
                          const SizedBox(height: 20),
                          Text(
                            'STILLNESS\nISN\'T\nLUXURY.',
                            style: AppTypography.display(color: AppColors.bone, size: isDesktop ? 76 : 46),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gutter, vertical: 90),
              child: Center(
                child: SizedBox(
                  width: isDesktop ? 760 : double.infinity,
                  child: Column(
                    children: [
                      Text(
                        '"GO! started as an argument in a Nairobi tailor shop — that '
                        'the fashion industry had confused stillness for elegance. We '
                        'brought that same argument to eyewear: a frame that can\'t '
                        'survive a run for a train, a sprint across a wet pavement, a '
                        'full day in motion, doesn\'t survive here."',
                        textAlign: TextAlign.center,
                        style: AppTypography.serifBody(size: 22, color: AppColors.ink.withOpacity(0.85)),
                      ),
                      const SizedBox(height: 20),
                      Text('— FOUNDER\'S NOTE', style: AppTypography.kinetic(size: 12, color: AppColors.steel)),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: AppColors.boneSoft,
              padding: EdgeInsets.symmetric(horizontal: gutter, vertical: 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionLabel(text: 'WHAT WE STAND FOR'),
                  const SizedBox(height: 40),
                  if (isDesktop)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _values
                          .map((v) => Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 40),
                                  child: _ValueBlock(title: v.title, body: v.body),
                                ),
                              ))
                          .toList(),
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _values
                          .map((v) => Padding(
                                padding: const EdgeInsets.only(bottom: 32),
                                child: _ValueBlock(title: v.title, body: v.body),
                              ))
                          .toList(),
                    ),
                ],
              ),
            ),
            const SiteFooter(),
          ],
        ),
      ),
    );
  }
}
