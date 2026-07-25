import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_eyewear/app/data/models/product_model.dart';
import '../../../global_widgets/go_button.dart';
import '../../../global_widgets/go_image.dart';
import '../../../global_widgets/nav_bar.dart';
import '../../../global_widgets/product_card.dart';
import '../../../global_widgets/responsive.dart';
import '../../../global_widgets/section_label.dart';
import '../../../global_widgets/site_footer.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';
import '../controllers/product_detail_controller.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final gutter = Responsive.gutter(context);
    final isDesktop = Responsive.isDesktop(context);
    final product = controller.product;

    final gallery = Obx(() {
      final active = controller.activeColor.value;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 3 / 4,
            child: GoImage(url: product.imageForColor(active)),
          ),
          const SizedBox(height: 14),
          Row(
            children: List.generate(product.colors.length, (i) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () => controller.selectColor(i),
                  child: Container(
                    width: 76,
                    height: 96,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: active == i ? AppColors.ink : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: GoImage(
                      url: product.imageUrl(
                        product.colors[i].photoBaseUrl,
                        width: 200,
                        height: 260,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      );
    });

    final info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionLabel(text: product.shape.label),
        const SizedBox(height: 18),
        Text(product.name, style: AppTypography.headline(size: 34)),
        const SizedBox(height: 10),
        Text(product.material, style: AppTypography.caption(size: 14)),
        const SizedBox(height: 18),
        Text(product.formattedPrice, style: AppTypography.price(size: 24)),
        const SizedBox(height: 26),
        Text(
          product.description,
          style: AppTypography.body(color: AppColors.ink.withOpacity(0.75)),
        ),
        const SizedBox(height: 32),
        Text(
          'COLOR',
          style: AppTypography.kinetic(size: 12, color: AppColors.steel),
        ),
        const SizedBox(height: 12),
        Obx(
          () => Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(product.colors.length, (i) {
              final active = controller.activeColor.value == i;
              final c = product.colors[i];
              return GestureDetector(
                onTap: () => controller.selectColor(i),
                child: Column(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: c.swatch,
                        border: Border.all(
                          color:
                              active
                                  ? AppColors.signal
                                  : AppColors.steel.withOpacity(0.4),
                          width: active ? 2.4 : 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(c.name, style: AppTypography.caption(size: 10)),
                  ],
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 30),
        Text(
          'LENS',
          style: AppTypography.kinetic(size: 12, color: AppColors.steel),
        ),
        const SizedBox(height: 12),
        Obx(
          () => Wrap(
            spacing: 10,
            runSpacing: 10,
            children:
                product.lensOptions.map((lens) {
                  final active = controller.selectedLens.value == lens;
                  return _Chip(
                    label: lens,
                    active: active,
                    onTap: () => controller.selectLens(lens),
                  );
                }).toList(),
          ),
        ),
        const SizedBox(height: 30),
        Text(
          'FRAME WIDTH',
          style: AppTypography.kinetic(size: 12, color: AppColors.steel),
        ),
        const SizedBox(height: 12),
        Obx(
          () => Wrap(
            spacing: 10,
            runSpacing: 10,
            children:
                product.frameWidths.map((width) {
                  final active = controller.selectedWidth.value == width;
                  return _Chip(
                    label: width,
                    active: active,
                    onTap: () => controller.selectWidth(width),
                  );
                }).toList(),
          ),
        ),
        const SizedBox(height: 34),
        GoButton(
          label: 'ADD TO BAG',
          onPressed: controller.addToBag,
          horizontalPadding: 44,
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            const Icon(
              Icons.verified_outlined,
              size: 16,
              color: AppColors.steel,
            ),
            const SizedBox(width: 8),
            Text(
              'UV400 protection, every pair',
              style: AppTypography.caption(),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(
              Icons.local_shipping_outlined,
              size: 16,
              color: AppColors.steel,
            ),
            const SizedBox(width: 8),
            Text(
              'Complimentary shipping on all orders',
              style: AppTypography.caption(),
            ),
          ],
        ),
      ],
    );

    return Scaffold(
      backgroundColor: AppColors.bone,
      appBar: const NavBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(gutter, 48, gutter, 80),
              child:
                  isDesktop
                      ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 6, child: gallery),
                          const SizedBox(width: 64),
                          Expanded(flex: 5, child: info),
                        ],
                      )
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [gallery, const SizedBox(height: 32), info],
                      ),
            ),
            if (controller.youMayAlsoLike.isNotEmpty)
              Container(
                color: AppColors.boneSoft,
                padding: EdgeInsets.symmetric(horizontal: gutter, vertical: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionLabel(text: 'YOU MAY ALSO LIKE'),
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 420,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.youMayAlsoLike.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 28),
                        itemBuilder:
                            (context, i) => SizedBox(
                              width: 260,
                              child: ProductCard(
                                product: controller.youMayAlsoLike[i],
                              ),
                            ),
                      ),
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

class _Chip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _Chip({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: active ? AppColors.ink : Colors.transparent,
          border: Border.all(color: active ? AppColors.ink : AppColors.steel),
        ),
        child: Text(
          label,
          style: AppTypography.bodyMedium(
            color: active ? AppColors.bone : AppColors.ink,
            size: 13,
          ),
        ),
      ),
    );
  }
}
