import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global_widgets/go_button.dart';
import '../../../global_widgets/go_image.dart';
import '../../../global_widgets/nav_bar.dart';
import '../../../global_widgets/responsive.dart';
import '../../../global_widgets/section_label.dart';
import '../../../global_widgets/site_footer.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';
import '../controllers/bag_controller.dart';

class BagView extends GetView<BagController> {
  const BagView({super.key});

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
            Padding(
              padding: EdgeInsets.fromLTRB(gutter, 56, gutter, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionLabel(text: 'YOUR BAG'),
                  const SizedBox(height: 16),
                  Obx(() => Text(
                        '${controller.bag.itemCount} ${controller.bag.itemCount == 1 ? 'Pair' : 'Pairs'}',
                        style: AppTypography.headline(size: 36),
                      )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gutter),
              child: Obx(() {
                final items = controller.bag.items;
                if (items.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    child: Column(
                      children: [
                        Text('Your bag is empty.', style: AppTypography.body()),
                        const SizedBox(height: 24),
                        GoButton(
                          label: 'CONTINUE SHOPPING',
                          onPressed: () => Get.offNamed(Routes.collection),
                        ),
                      ],
                    ),
                  );
                }

                final list = Column(
                  children: items
                      .map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 28),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 110,
                                  height: 140,
                                  child: GoImage(url: item.product.coverImage),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.product.name, style: AppTypography.bodyMedium(size: 16)),
                                      const SizedBox(height: 6),
                                      Text(
                                        '${item.colorName} · ${item.lensOption} · ${item.frameWidth} fit',
                                        style: AppTypography.caption(),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(item.product.formattedPrice, style: AppTypography.price()),
                                      const SizedBox(height: 14),
                                      Row(
                                        children: [
                                          _QtyButton(
                                            icon: Icons.remove,
                                            onTap: () => controller.bag.decrement(item),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
                                            child: Obx(() => Text('${item.quantity.value}', style: AppTypography.bodyMedium())),
                                          ),
                                          _QtyButton(
                                            icon: Icons.add,
                                            onTap: () => controller.bag.increment(item),
                                          ),
                                          const SizedBox(width: 20),
                                          GestureDetector(
                                            onTap: () => controller.bag.remove(item),
                                            child: Text(
                                              'REMOVE',
                                              style: AppTypography.kinetic(size: 11, color: AppColors.steel),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                );

                final summary = Container(
                  padding: const EdgeInsets.all(28),
                  color: AppColors.boneSoft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ORDER SUMMARY', style: AppTypography.kinetic(size: 12, color: AppColors.steel)),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Subtotal', style: AppTypography.body()),
                          Text('\$${controller.bag.subtotal.toStringAsFixed(0)}', style: AppTypography.bodyMedium()),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Shipping', style: AppTypography.body()),
                          Text('Complimentary', style: AppTypography.bodyMedium()),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(height: 1, color: AppColors.divider),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total', style: AppTypography.headline(size: 20)),
                          Text('\$${controller.bag.subtotal.toStringAsFixed(0)}', style: AppTypography.headline(size: 20)),
                        ],
                      ),
                      const SizedBox(height: 28),
                      GoButton(label: 'CHECKOUT', onPressed: controller.checkout),
                    ],
                  ),
                );

                return Padding(
                  padding: const EdgeInsets.only(bottom: 90),
                  child: isDesktop
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 7, child: list),
                            const SizedBox(width: 48),
                            Expanded(flex: 4, child: summary),
                          ],
                        )
                      : Column(children: [list, const SizedBox(height: 32), summary]),
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

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(color: AppColors.steel)),
        child: Icon(icon, size: 14, color: AppColors.ink),
      ),
    );
  }
}
