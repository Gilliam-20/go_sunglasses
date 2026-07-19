import 'package:get/get.dart';
import '../../../data/models/product_model.dart';
import '../../../data/repositories/product_repository.dart';

class CollectionController extends GetxController {
  final Rx<FrameShape?> selected = Rx<FrameShape?>(null);

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg is FrameShape) selected.value = arg;
  }

  List<ProductModel> get products {
    if (selected.value == null) return ProductRepository.to.all();
    return ProductRepository.to.byShape(selected.value!);
  }

  void select(FrameShape? shape) => selected.value = shape;
}
