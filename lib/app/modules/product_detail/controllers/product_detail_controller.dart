import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/product_model.dart';
import '../../../data/repositories/bag_service.dart';
import '../../../data/repositories/product_repository.dart';

class ProductDetailController extends GetxController {
  late final ProductModel product;
  final RxInt activeColor = 0.obs;
  final RxString selectedLens = ''.obs;
  final RxString selectedWidth = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final id = Get.parameters['id'];
    product = ProductRepository.to.byId(id ?? '');
    selectedLens.value = product.lensOptions.first;
    selectedWidth.value = product.frameWidths[product.frameWidths.length ~/ 2];
  }

  void selectColor(int index) => activeColor.value = index;

  void selectLens(String lens) => selectedLens.value = lens;

  void selectWidth(String width) => selectedWidth.value = width;

  void addToBag() {
    BagService.to.add(
      product,
      colorName: product.colors[activeColor.value].name,
      lensOption: selectedLens.value,
      frameWidth: selectedWidth.value,
    );
    Get.snackbar(
      'ADDED TO BAG',
      '${product.name} · ${product.colors[activeColor.value].name}',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      duration: const Duration(seconds: 2),
    );
  }

  List<ProductModel> get youMayAlsoLike => ProductRepository.to
      .byShape(product.shape)
      .where((p) => p.id != product.id)
      .take(3)
      .toList();
}
