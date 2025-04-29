import 'package:get/get.dart';

import '../../features/contact_us/binding/contact_us_binding.dart';
import '../../features/contact_us/screen/contact_us_screen.dart';
import '../../features/splash/binding/splash_binding.dart';
import '../../features/splash/screen/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.initial, page: () => const SplashScreen(), binding: SplashBinding()),
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen(), binding: SplashBinding()),
    GetPage(
      name: AppRoutes.contactUs,
      page: () => const ContactUsScreen(),
      binding: ContactUsBinding(),
    ),
    // Add other routes here as they are developed
  ];
}
