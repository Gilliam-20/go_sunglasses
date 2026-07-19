import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/product_model.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'go_mark.dart';
import 'responsive.dart';
import 'section_label.dart';

class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final gutter = Responsive.gutter(context);

    final brandBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const GoMark(size: 30, light: true),
        const SizedBox(height: 18),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 340),
          child: Text(
            'Eyewear built for velocity. New drops, '
            'straight to your inbox — no noise, no spam.',
            style: AppTypography.body(color: AppColors.chrome, size: 14),
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () => Get.toNamed(Routes.contact),
          child: const SectionLabel(text: 'JOIN THE LIST', color: AppColors.bone),
        ),
      ],
    );

    final shopColumn = _FooterColumn(
      title: 'SHOP',
      items: const ['Aviator', 'Round', 'Cat-Eye', 'Rectangle'],
      onTap: (label) {
        final shape = switch (label) {
          'Aviator' => FrameShape.aviator,
          'Round' => FrameShape.round,
          'Cat-Eye' => FrameShape.catEye,
          'Rectangle' => FrameShape.rectangle,
          _ => null,
        };
        Get.toNamed(Routes.collection, arguments: shape);
      },
    );

    final houseColumn = _FooterColumn(
      title: 'HOUSE',
      items: const ['About', 'Find Your Fit', 'Contact'],
      onTap: (label) {
        if (label == 'Contact') {
          Get.toNamed(Routes.contact);
        } else if (label == 'About') {
          Get.toNamed(Routes.about);
        } else if (label == 'Find Your Fit') {
          Get.toNamed(Routes.findYourFit);
        }
      },
    );

    return Container(
      color: AppColors.ink,
      padding: EdgeInsets.fromLTRB(gutter, 72, gutter, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: brandBlock),
                    const Spacer(),
                    Expanded(flex: 3, child: shopColumn),
                    const SizedBox(width: 40),
                    Expanded(flex: 3, child: houseColumn),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    brandBlock,
                    const SizedBox(height: 40),
                    shopColumn,
                    const SizedBox(height: 32),
                    houseColumn,
                  ],
                ),
          const SizedBox(height: 56),
          Container(height: 1, color: AppColors.dividerOnDark),
          const SizedBox(height: 20),
          Flex(
            direction: isDesktop ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '© ${DateTime.now().year} GO! EYEWEAR. ALL RIGHTS RESERVED.',
                style: AppTypography.caption(color: AppColors.steelLight, size: 11),
              ),
              if (isDesktop) const Spacer(),
              if (!isDesktop) const SizedBox(height: 8),
              Text(
                'NAIROBI · MILAN · TOKYO',
                style: AppTypography.caption(color: AppColors.steelLight, size: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterColumn extends StatelessWidget {
  final String title;
  final List<String> items;
  final void Function(String) onTap;
  const _FooterColumn({required this.title, required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.kinetic(color: AppColors.steelLight, size: 12)),
        const SizedBox(height: 18),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: () => onTap(item),
              child: Text(item, style: AppTypography.body(color: AppColors.bone, size: 14)),
            ),
          ),
        ),
      ],
    );
  }
}
