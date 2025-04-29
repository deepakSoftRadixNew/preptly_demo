import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preptly/core/constants/app_colors.dart';

/// A reusable TextFormField widget with consistent styling.
class CommonTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final String? hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final bool enabled;
  final bool readOnly;
  final AutovalidateMode autovalidateMode;
  final VoidCallback? onTap;
  final BoxConstraints? prefixIconConstraints;

  const CommonTextFormField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.label,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.enabled = true,
    this.readOnly = false,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onTap,
    this.prefixIconConstraints,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Field label
        Text(
          label,
          style: GoogleFonts.ptSans(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor,
          ),
        ),
        SizedBox(height: 8.h),

        // TextFormField
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          obscureText: obscureText,
          maxLines: maxLines,
          minLines: minLines,
          onChanged: onChanged,
          validator: validator,
          autovalidateMode: autovalidateMode,
          onFieldSubmitted: onFieldSubmitted,
          enabled: enabled,
          readOnly: readOnly,
          onTap: onTap,
          style: GoogleFonts.ptSans(fontSize: 16.sp),
          decoration: InputDecoration(
            hintText: hintText,
            // labelText: label,
            alignLabelWithHint: maxLines != null && maxLines! > 1,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            prefixIconConstraints: prefixIconConstraints,
            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
          ),
        ),
      ],
    );
  }
}
