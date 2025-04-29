import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/di/di.dart';
import '../../../core/widgets/common_button.dart';
import '../cubit/contact_us_cubit.dart';
import '../cubit/contact_us_state.dart';

/// ContactUsScreen displays a form for users to send inquiries.
///
/// This screen follows the BLoC/Cubit pattern with a cubit
/// for managing state and business logic. The UI adapts between a form
/// and a success message based on the submission state.
class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => getIt<ContactUsCubit>(), child: const ContactUsView());
  }
}

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.contactUs)),
      // Dismiss keyboard when tapping outside of text fields
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocBuilder<ContactUsCubit, ContactUsState>(
          builder: (context, state) {
            return state.isFormSubmitted ? _buildSuccessMessage(context) : _buildForm(context);
          },
        ),
      ),
    );
  }

  // MARK: - UI Components

  /// Builds the success message shown after form submission
  Widget _buildSuccessMessage(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSuccessIcon(),
            SizedBox(height: 20.h),
            _buildSuccessText(),
            SizedBox(height: 30.h),
            _buildOkButton(context),
          ],
        ),
      ),
    );
  }

  /// Builds the success checkmark icon
  Widget _buildSuccessIcon() {
    return Icon(Icons.check_circle, color: AppColors.primaryColor, size: 80.w);
  }

  /// Builds the success message text
  Widget _buildSuccessText() {
    return Text(
      AppStrings.formSubmittedSuccessfully,
      style: GoogleFonts.ptSans(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
      textAlign: TextAlign.center,
    );
  }

  /// Builds the OK button to reset the form
  Widget _buildOkButton(BuildContext context) {
    final cubit = context.read<ContactUsCubit>();
    return CommonButton(text: AppStrings.ok, onPressed: cubit.resetForm, width: 150.w);
  }

  /// Builds the contact form with input fields
  Widget _buildForm(BuildContext context) {
    final cubit = context.read<ContactUsCubit>();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: cubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFormField(
                context: context,
                label: AppStrings.name,
                hint: AppStrings.enterName,
                controller: cubit.nameController,
                validator: cubit.validateName,
                onChanged: cubit.updateNameError,
              ),
              SizedBox(height: 16.h),

              _buildFormField(
                context: context,
                label: AppStrings.email,
                hint: AppStrings.enterEmail,
                controller: cubit.emailController,
                validator: cubit.validateEmail,
                keyboardType: TextInputType.emailAddress,
                onChanged: cubit.updateEmailError,
              ),
              SizedBox(height: 16.h),

              _buildFormField(
                context: context,
                label: AppStrings.message,
                hint: AppStrings.enterMessage,
                controller: cubit.messageController,
                validator: cubit.validateMessage,
                maxLines: 5,
                onChanged: cubit.updateMessageError,
              ),
              SizedBox(height: 30.h),

              _buildSubmitButton(context),

              // Show error message if form submission failed
              _buildErrorMessage(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a form field with label and input field
  Widget _buildFormField({
    required BuildContext context,
    required String label,
    required String hint,
    required TextEditingController controller,
    required String? Function(String?) validator,
    required void Function(String?) onChanged,
    TextInputType? keyboardType,
    int? maxLines,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel(label),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          maxLines: maxLines ?? 1,
          onChanged: onChanged,
          decoration: InputDecoration(hintText: hint),
          style: GoogleFonts.ptSans(fontSize: 16.sp),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ],
    );
  }

  /// Builds a field label with consistent styling
  Widget _buildFieldLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.ptSans(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.blackColor,
      ),
    );
  }

  /// Builds the submit button with loading state
  Widget _buildSubmitButton(BuildContext context) {
    return BlocBuilder<ContactUsCubit, ContactUsState>(
      buildWhen: (previous, current) => previous.isLoading != current.isLoading,
      builder: (context, state) {
        final cubit = context.read<ContactUsCubit>();
        return CommonButton(
          text: AppStrings.submit,
          onPressed: cubit.submitForm,
          isLoading: state.isLoading,
        );
      },
    );
  }

  /// Builds error message for form submission failure
  Widget _buildErrorMessage(BuildContext context) {
    return BlocBuilder<ContactUsCubit, ContactUsState>(
      buildWhen:
          (previous, current) =>
              previous.isFailure != current.isFailure ||
              previous.errorMessage != current.errorMessage,
      builder: (context, state) {
        if (!state.isFailure || state.errorMessage == null) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: EdgeInsets.only(top: 16.h),
          child: Text(
            state.errorMessage!,
            style: GoogleFonts.ptSans(fontSize: 14.sp, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
