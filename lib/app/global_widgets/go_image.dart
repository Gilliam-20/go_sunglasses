import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Wraps [Image.network] with a brand-consistent loading and error state,
/// so a slow or unreachable image never breaks the layout.
///
/// NOTE ON IMAGE SOURCES — read this before launch:
/// Every photo on the site is loaded live from https://picsum.photos using
/// a named seed (see `ProductModel.imageUrl`). Picsum is a free, royalty-free
/// placeholder photo service — it guarantees the app renders real
/// photography out of the box, but the images are NOT curated fashion
/// campaign shots. Before shipping, replace the seeds in
/// `product_repository.dart` and the hero/lookbook seeds in
/// `home_controller.dart` / `lookbook_controller.dart` with your own
/// hosted product photography URLs (Firebase Storage, Cloudinary, etc).
/// Because every image is resolved through this one widget, swapping the
/// source later only means changing the URL strings, not this file.
class GoImage extends StatelessWidget {
  final String url;
  final BoxFit fit;

  const GoImage({super.key, required this.url, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          color: AppColors.boneSoft,
          child: const Center(
            child: SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 1.6,
                color: AppColors.signal,
              ),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stack) => Container(
        color: AppColors.boneSoft,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.image_outlined, color: AppColors.steel, size: 28),
            const SizedBox(height: 6),
            Text(
              'Image unavailable',
              style: TextStyle(color: AppColors.steel, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
