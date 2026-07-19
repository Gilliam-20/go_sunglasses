import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global_widgets/go_image.dart';
import '../../../global_widgets/nav_bar.dart';
import '../../../global_widgets/responsive.dart';
import '../../../global_widgets/section_label.dart';
import '../../../global_widgets/site_footer.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';
import '../controllers/lookbook_controller.dart';

class LookbookView extends GetView<LookbookController> {
  const LookbookView({super.key});

  static const _heights = [420.0, 320.0, 500.0, 380.0];

  @override
  Widget build(BuildContext context) {
    final gutter = Responsive.gutter(context);
    final columnCount = Responsive.isDesktop(context) ? 3 : (Responsive.isTablet(context) ? 2 : 1);
    final seeds = controller.seeds;
    final columns = List.generate(columnCount, (_) => <String>[]);
    for (var i = 0; i < seeds.length; i++) {
      columns[i % columnCount].add(seeds[i]);
    }

    return Scaffold(
      backgroundColor: AppColors.ink,
      appBar: const NavBar(light: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(gutter, 56, gutter, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionLabel(text: 'SS26 EDITORIAL', color: AppColors.bone),
                  const SizedBox(height: 16),
                  Text('The Lookbook', style: AppTypography.headline(size: 44, color: AppColors.bone)),
                  const SizedBox(height: 14),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Text(
                      'Eight frames from the SS26 campaign, shot in motion '
                      'rather than posed against it.',
                      style: AppTypography.body(color: AppColors.chrome, size: 15),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gutter, vertical: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(columnCount, (colIndex) {
                  final colSeeds = columns[colIndex];
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: colIndex == columnCount - 1 ? 0 : 20),
                      child: Column(
                        children: List.generate(colSeeds.length, (i) {
                          final height = _heights[(colIndex + i) % _heights.length];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SizedBox(
                              height: height,
                              width: double.infinity,
                              child: GoImage(
                                url: 'https://picsum.photos/seed/${colSeeds[i]}/800/${height.toInt() * 2}?grayscale',
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  );
                }),
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
