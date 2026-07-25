import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Wraps [Image.network] with a brand-consistent loading and error state,
/// so a slow or unreachable image never breaks the layout.
///
/// NOTE ON IMAGE SOURCES — read this before launch:
/// Every photo on the site is real sunglasses photography from Unsplash
/// (images.unsplash.com), loaded live over the network — see
/// `lib/app/data/unsplash_photos.dart` for the full registry, source
/// credits, and the `sized()` helper that applies width/height/crop/
/// grayscale via query params. Every image is confirmed "Free to use
/// under the Unsplash License" (free for commercial use, no attribution
/// legally required), but it's free stock photography, not per-SKU
/// product shoots — several products intentionally share a photo where
/// only one clean shot of that frame shape was available. Before
/// shipping, replace the URLs in `unsplash_photos.dart` with your own
/// hosted product photography (Firebase Storage, Cloudinary, etc) — see
/// README.md for exactly which lines to touch. Because every image is
/// resolved through this one widget, swapping the source later only
/// means changing URL strings, not this file.
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
