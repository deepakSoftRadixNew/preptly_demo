import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/common_button.dart';
import '../controller/contact_us_controller.dart';

class ContactUsScreen extends GetView<ContactUsController> {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.contactUs)),
      body: Obx(() {
        return controller.isFormSubmitted.value ? _buildSuccessMessage() : _buildForm();
      }),
    );
  }

  Widget _buildSuccessMessage() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: AppColors.primaryColor, size: 80.w),
            SizedBox(height: 20.h),
            Text(
              AppStrings.formSubmittedSuccessfully,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.h),
            CommonButton(text: AppStrings.ok, onPressed: controller.resetForm, width: 150.w),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.name,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: controller.nameController,
                validator: controller.validateName,
                decoration: InputDecoration(hintText: AppStrings.enterName),
              ),
              SizedBox(height: 16.h),
              Text(
                AppStrings.email,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: controller.emailController,
                validator: controller.validateEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: AppStrings.enterEmail),
              ),
              SizedBox(height: 16.h),
              Text(
                AppStrings.message,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: controller.messageController,
                validator: controller.validateMessage,
                maxLines: 5,
                decoration: InputDecoration(hintText: AppStrings.enterMessage),
              ),
              SizedBox(height: 30.h),
              Obx(
                () => CommonButton(
                  text: AppStrings.submit,
                  onPressed: controller.submitForm,
                  isLoading: controller.isLoading.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
