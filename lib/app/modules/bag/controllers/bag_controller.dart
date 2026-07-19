import 'package:get/get.dart';
import '../../../data/repositories/bag_service.dart';

class BagController extends GetxController {
  BagService get bag => BagService.to;

  void checkout() {
    Get.snackbar(
      'GO! CHECKOUT',
      'Checkout is not wired up yet — connect your payment flow here.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
