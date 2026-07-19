import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/product_model.dart';
import '../../../data/repositories/product_repository.dart';

class HomeController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final RxBool solidNav = false.obs;

  List<ProductModel> get featured => ProductRepository.to.featured(count: 4);

  static const heroImageSeed = 'go-eyewear-hero-main';
  static const editorialImageSeed = 'go-eyewear-editorial-teaser';

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
