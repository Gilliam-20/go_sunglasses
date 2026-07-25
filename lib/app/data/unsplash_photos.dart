/// Real sunglasses photography sourced from Unsplash, all confirmed
/// "Free to use under the Unsplash License" (unsplash.com/license) —
/// free for commercial use, no attribution legally required.
///
/// Each constant is the photo's base CDN URL (images.unsplash.com serves
/// through an Imgix-compatible pipeline, so width/height/crop/grayscale
/// are all applied via query params at the call site — see
/// `ProductModel.imageUrl`). Source photo pages, credited here as a
/// courtesy to the photographers even though the license doesn't require
/// it:
///
/// - auroraAviatorGold    unsplash.com/photos/gold-framed-aviator-style-sunglasses-21A678_OSio (Laura Chouette)
/// - auroraAviatorSilver  unsplash.com/photos/silver-framed-aviator-style-sunglasses-MivM1hirbUI (Habib Dadkhah)
/// - roundOrangeMotion    unsplash.com/photos/man-wearing-round-orange-sunglasses-and-black-jacket-7L1iaJ5Cxkk (Karsten Winegeart)
/// - roundOnBlueCircle    unsplash.com/photos/a-pair-of-sunglasses-sitting-on-top-of-a-blue-circle-eHk4scAyUzU (Mahbod Akhzami)
/// - catEyeBlueFramed     unsplash.com/photos/JJriiwCxutM (Tamara Bellis)
/// - wayfarerFlatlay      unsplash.com/photos/flat-lay-photography-of-wayfarer-style-sunglasses-and-macbook-pro-qr2cn19ixQs (Kirill)
/// - sunglassesInBox      unsplash.com/photos/a-pair-of-sunglasses-sitting-inside-of-a-box-MP1KqREt-sU (Lenzil Gonsalves)
/// - onWhiteStillLife     unsplash.com/photos/a-pair-of-sunglasses-sitting-on-top-of-a-white-object-7zVkSRYgQ4k (Kate Laine)
/// - onWoodenTable        unsplash.com/photos/a-pair-of-sunglasses-sitting-on-top-of-a-wooden-table-gbu0_0mENH8 (Na sen)
/// - onRock               unsplash.com/photos/a-pair-of-sunglasses-sitting-on-top-of-a-rock-SfrDl6UOifk (Old Youth)
/// - onWhiteSurfaceShadow unsplash.com/photos/sunglasses-on-white-surface--ru0KD7SwBA (Dan Gold)
/// - bwPortraitWithHat    unsplash.com/photos/a-black-and-white-photo-of-a-person-wearing-sunglasses-and-a-hat-CLIhXCeDsJU (Mad Knoxx Deluxe)
/// - closeUpNeonLights    unsplash.com/photos/a-close-up-of-a-person-wearing-sunglasses-QXrECy2ieX8 (Antonio DiCaterina)
///
/// NOTE ON REUSE: this is free stock photography, not per-SKU product
/// shoots — several products intentionally share a photo (e.g. all three
/// cat-eye frames use the one clean cat-eye stock photo available). See
/// README.md for exactly which lines to update once you have real
/// per-color product photography.
class UnsplashPhotos {
  UnsplashPhotos._();

  static const auroraAviatorGold = 'https://images.unsplash.com/photo-1614179818428-220dcc46fe8c';
  static const auroraAviatorSilver = 'https://images.unsplash.com/photo-1589642380614-4a8c2147b857';
  static const roundOrangeMotion = 'https://images.unsplash.com/photo-1761582286153-03b935a8a41e';
  static const roundOnBlueCircle = 'https://images.unsplash.com/photo-1685715481110-19db0a76de2f';
  static const catEyeBlueFramed = 'https://images.unsplash.com/photo-1485340619878-bb139d7bcd15';
  static const wayfarerFlatlay = 'https://images.unsplash.com/photo-1517330486404-33542d376afd';
  static const sunglassesInBox = 'https://images.unsplash.com/photo-1601045058749-ea47f835114b';
  static const onWhiteStillLife = 'https://images.unsplash.com/photo-1695157712101-7336d70c373e';
  static const onWoodenTable = 'https://images.unsplash.com/photo-1653038282660-266890e79e59';
  static const onRock = 'https://images.unsplash.com/photo-1681147767903-9011e9bf9e83';
  static const onWhiteSurfaceShadow = 'https://images.unsplash.com/photo-1506359368206-1c055e47e971';
  static const bwPortraitWithHat = 'https://images.unsplash.com/photo-1712047153577-0119ce1f5767';
  static const closeUpNeonLights = 'https://images.unsplash.com/photo-1514446945-952d86c3449b';

  /// All photos, for the lookbook rotation.
  static const all = [
    onWhiteStillLife,
    bwPortraitWithHat,
    onWoodenTable,
    onRock,
    onWhiteSurfaceShadow,
    closeUpNeonLights,
    roundOrangeMotion,
    catEyeBlueFramed,
  ];

  /// Builds a sized/cropped image URL from a base Unsplash CDN URL.
  /// images.unsplash.com serves through an Imgix-compatible pipeline, so
  /// width/height/crop/format/grayscale are all controlled via query
  /// params — no download or re-hosting needed.
  static String sized(String baseUrl, {int width = 900, int height = 1100, bool grayscale = false}) {
    final sat = grayscale ? '&sat=-100' : '';
    return '$baseUrl?auto=format&fit=crop&w=$width&h=$height&q=80$sat';
  }
}
