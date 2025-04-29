import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preptly/core/constants/app_colors.dart';
import 'package:preptly/core/constants/app_strings.dart';
import 'package:preptly/core/di/di.dart';
import 'package:preptly/core/routes/app_routes.dart';
import 'package:preptly/core/routes/navigation_helper.dart';
import 'package:preptly/features/splash/cubit/splash_cubit.dart';
import 'package:preptly/features/splash/cubit/splash_state.dart';

/// SplashScreen displays a splash screen with animation
/// and automatically navigates to the next screen after delay.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => getIt<SplashCubit>(), child: const SplashView());
  }
}

/// SplashView implements the UI for the splash screen
/// and provides the TickerProvider for animations.
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // Initialize the cubit with this TickerProvider
    context.read<SplashCubit>().initialize(this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashState>(
      listenWhen: (previous, current) => current.isNavigating && !previous.isNavigating,
      listener: (context, state) {
        // Handle navigation when ready
        NavigationHelper.replaceTo(context, AppRoutes.contactUs);
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: Center(
            child: AnimatedOpacity(
              opacity: state.animationValue,
              duration: const Duration(milliseconds: 300),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 24.h),
                  _buildAppName(),
                  SizedBox(height: 80.h),
                  _buildLoadingIndicator(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppName() {
    return Text(
      AppStrings.appName,
      style: GoogleFonts.ptSans(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.whiteColor,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: 40.w,
      height: 40.w,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.whiteColor),
        strokeWidth: 2.w,
      ),
    );
  }
}
