import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:preptly/core/constants/app_colors.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool showLoader;
  final double? width;
  final Color? backgroundColor;
  final Color? textColor;

  const CommonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.showLoader = true,
    this.width,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primaryColor,
          foregroundColor: textColor ?? AppColors.whiteColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        ),
        child:
            isLoading && showLoader
                ? SizedBox(
                  height: 24.h,
                  width: 24.w,
                  child: CircularProgressIndicator(color: AppColors.whiteColor, strokeWidth: 2.w),
                )
                : Text(text, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
