import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/data/repositories/bag_service.dart';
import 'app/data/repositories/product_repository.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // App-wide services are registered once, before any route builds, so
  // every module can rely on ProductRepository.to / BagService.to being
  // ready immediately.
  await Get.putAsync<ProductRepository>(() => ProductRepository().init());
  Get.put<BagService>(BagService());

  runApp(const GoApp());
}

class GoApp extends StatelessWidget {
  const GoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GO! Eyewear — Sunglasses Built for Velocity',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: Routes.home,
      getPages: AppPages.pages,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 260),
    );
  }
}
