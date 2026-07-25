import 'package:flutter/material.dart';
import '../../../data/models/product_model.dart';
import '../../../global_widgets/nav_bar.dart';
import '../../../global_widgets/product_card.dart';
import '../../../global_widgets/responsive.dart';
import '../../../global_widgets/section_label.dart';
import '../../../global_widgets/site_footer.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';
import '../controllers/collection_controller.dart';
import 'package:get/get.dart';

class CollectionView extends GetView<CollectionController> {
  const CollectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final gutter = Responsive.gutter(context);
    final columns = Responsive.gridColumns(context);

    return Scaffold(
      backgroundColor: AppColors.bone,
      appBar: const NavBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(gutter, 56, gutter, 32),
              color: AppColors.bone,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionLabel(text: 'THE COLLECTION'),
                  const SizedBox(height: 16),
                  Text(
                    'Every Frame,\nBuilt to Move.',
                    style: AppTypography.headline(size: 44),
                  ),
                  const SizedBox(height: 32),
                  Obx(
                    () => Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _FilterChip(
                          label: 'ALL',
                          active: controller.selected.value == null,
                          onTap: () => controller.select(null),
                        ),
                        _FilterChip(
                          label: 'AVIATOR',
                          active:
                              controller.selected.value == FrameShape.aviator,
                          onTap: () => controller.select(FrameShape.aviator),
                        ),
                        _FilterChip(
                          label: 'ROUND',
                          active: controller.selected.value == FrameShape.round,
                          onTap: () => controller.select(FrameShape.round),
                        ),
                        _FilterChip(
                          label: 'CAT-EYE',
                          active:
                              controller.selected.value == FrameShape.catEye,
                          onTap: () => controller.select(FrameShape.catEye),
                        ),
                        _FilterChip(
                          label: 'RECTANGLE',
                          active:
                              controller.selected.value == FrameShape.rectangle,
                          onTap: () => controller.select(FrameShape.rectangle),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(gutter, 16, gutter, 96),
              child: Obx(() {
                final products = controller.products;
                if (products.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 80),
                    child: Center(
                      child: Text(
                        'No frames in this line yet.',
                        style: AppTypography.body(),
                      ),
                    ),
                  );
                }
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    mainAxisSpacing: 32,
                    crossAxisSpacing: 28,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder:
                      (context, i) => ProductCard(product: products[i]),
                );
              }),
            ),
            const SiteFooter(),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _FilterChip({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: active ? AppColors.ink : Colors.transparent,
          border: Border.all(color: active ? AppColors.ink : AppColors.steel),
        ),
        child: Text(
          label,
          style: AppTypography.kinetic(
            color: active ? AppColors.bone : AppColors.ink,
            size: 12,
          ),
        ),
      ),
    );
  }
}
