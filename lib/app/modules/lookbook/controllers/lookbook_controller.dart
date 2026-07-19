import 'package:get/get.dart';
import '../../../data/repositories/product_repository.dart';

class LookbookController extends GetxController {
  List<String> get seeds => ProductRepository.to.lookbookSeeds;
}
