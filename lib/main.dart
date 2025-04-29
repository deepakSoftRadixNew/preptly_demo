import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/constants/app_strings.dart';
import 'core/di/di.dart';
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';

/// To generate app icons:
/// 1. Convert SVG icons to PNG:
///    - assets/icon/app_icon.svg -> assets/icon/app_icon.png
///    - assets/icon/app_icon_foreground.svg -> assets/icon/app_icon_foreground.png
/// 2. Run: flutter pub run flutter_launcher_icons

void main() {
  // Initialize dependency injection
  configureDependencies();

  // Initialize Google Fonts
  GoogleFonts.config.allowRuntimeFetching = true;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: AppStrings.appName,
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: getIt<AppRouter>().router,
        );
      },
    );
  }
}
