import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/product_model.dart';
import '../../../data/repositories/product_repository.dart';
import '../../../data/unsplash_photos.dart';

class HomeController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final RxBool solidNav = false.obs;

  List<ProductModel> get featured => ProductRepository.to.featured(count: 4);

  // "motion blur", "editorial" — a near-perfect match for the brand line.
  static const heroImageUrl = UnsplashPhotos.roundOrangeMotion;
  static const editorialImageUrl = UnsplashPhotos.closeUpNeonLights;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      final shouldBeSolid = scrollController.offset > 80;
      if (shouldBeSolid != solidNav.value) solidNav.value = shouldBeSolid;
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
