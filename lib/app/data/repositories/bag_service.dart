import 'package:get/get.dart';
import '../models/product_model.dart';

class BagItem {
  final ProductModel product;
  final String colorName;
  final String lensOption;
  final String frameWidth;
  final RxInt quantity;

  BagItem({
    required this.product,
    required this.colorName,
    required this.lensOption,
    required this.frameWidth,
    int quantity = 1,
  }) : quantity = quantity.obs;

  double get subtotal => product.price * quantity.value;
}

/// Holds the shopping bag across the whole app. A GetxService (not a
/// controller) because the bag must survive navigation between the
/// collection, product detail, and bag screens.
class BagService extends GetxService {
  static BagService get to => Get.find<BagService>();

  final RxList<BagItem> items = <BagItem>[].obs;

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity.value);

  double get subtotal => items.fold(0.0, (sum, item) => sum + item.subtotal);

  void add(ProductModel product, {required String colorName, required String lensOption, required String frameWidth}) {
    BagItem? existing;
    for (final item in items) {
      if (item.product.id == product.id &&
          item.colorName == colorName &&
          item.lensOption == lensOption &&
          item.frameWidth == frameWidth) {
        existing = item;
        break;
      }
    }
    if (existing != null) {
      existing.quantity.value++;
    } else {
      items.add(BagItem(
        product: product,
        colorName: colorName,
        lensOption: lensOption,
        frameWidth: frameWidth,
      ));
    }
    items.refresh();
  }

  void remove(BagItem item) => items.remove(item);

  void increment(BagItem item) => item.quantity.value++;

  void decrement(BagItem item) {
    if (item.quantity.value > 1) {
      item.quantity.value--;
    } else {
      items.remove(item);
    }
  }
}
