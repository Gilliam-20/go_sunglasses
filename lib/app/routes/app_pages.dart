import 'package:get/get.dart';
import '../modules/about/views/about_view.dart';
import '../modules/bag/bindings/bag_binding.dart';
import '../modules/bag/views/bag_view.dart';
import '../modules/collection/bindings/collection_binding.dart';
import '../modules/collection/views/collection_view.dart';
import '../modules/contact/bindings/contact_binding.dart';
import '../modules/contact/views/contact_view.dart';
import '../modules/find_your_fit/views/find_your_fit_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/lookbook/bindings/lookbook_binding.dart';
import '../modules/lookbook/views/lookbook_view.dart';
import '../modules/product_detail/bindings/product_detail_binding.dart';
import '../modules/product_detail/views/product_detail_view.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final pages = [
    GetPage(name: Routes.home, page: () => const HomeView(), binding: HomeBinding()),
    GetPage(
      name: Routes.collection,
      page: () => const CollectionView(),
      binding: CollectionBinding(),
    ),
    GetPage(
      name: Routes.productDetail,
      page: () => const ProductDetailView(),
      binding: ProductDetailBinding(),
    ),
    GetPage(name: Routes.findYourFit, page: () => const FindYourFitView()),
    GetPage(
      name: Routes.lookbook,
      page: () => const LookbookView(),
      binding: LookbookBinding(),
    ),
    GetPage(name: Routes.about, page: () => const AboutView()),
    GetPage(name: Routes.bag, page: () => const BagView(), binding: BagBinding()),
    GetPage(
      name: Routes.contact,
      page: () => const ContactView(),
      binding: ContactBinding(),
    ),
  ];
}
