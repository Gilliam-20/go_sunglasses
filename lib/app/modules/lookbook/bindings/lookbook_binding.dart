import 'package:get/get.dart';
import '../controllers/lookbook_controller.dart';

class LookbookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LookbookController>(() => LookbookController());
  }
}
