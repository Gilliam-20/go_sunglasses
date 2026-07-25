import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/product_model.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'go_image.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: () => Get.toNamed(Routes.productDetailPath(p.id)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 3 / 4,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AnimatedScale(
                      scale: _hovering ? 1.045 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      child: GoImage(url: p.coverImage),
                    ),
                    AnimatedOpacity(
                      opacity: _hovering ? 1 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              AppColors.ink.withOpacity(0.55),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Text(
                          'VIEW FRAME',
                          style: AppTypography.kinetic(
                            color: AppColors.bone,
                            size: 11,
                            spacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Text(p.name, style: AppTypography.bodyMedium(size: 15)),
              const SizedBox(height: 4),
              Text(p.material, style: AppTypography.caption()),
              const SizedBox(height: 6),
              Text(p.formattedPrice, style: AppTypography.price()),
            ],
          ),
        ),
      ),
    );
  }
}
