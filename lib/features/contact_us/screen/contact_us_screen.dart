import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preptly/core/constants/app_colors.dart';
import 'package:preptly/core/constants/app_strings.dart';
import 'package:preptly/core/di/di.dart';
import 'package:preptly/core/widgets/common_button.dart';
import 'package:preptly/core/widgets/common_text_form_field.dart';
import 'package:preptly/features/contact_us/cubit/contact_us_cubit.dart';
import 'package:preptly/features/contact_us/cubit/contact_us_state.dart';

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
              _buildNameField(context, cubit),
              SizedBox(height: 16.h),

              _buildEmailField(context, cubit),
              SizedBox(height: 16.h),

              _buildMessageField(context, cubit),
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

  /// Builds the name input field
  Widget _buildNameField(BuildContext context, ContactUsCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextFormField(
          label: AppStrings.name,
          focusNode: cubit.nameFocusNode,
          controller: cubit.nameController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          onFieldSubmitted:
              (_) => cubit.fieldFocusChange(context, cubit.nameFocusNode, cubit.emailFocusNode),
          validator: cubit.validateName,
          onChanged: cubit.updateNameError,
          hintText: AppStrings.enterName,
          prefixIcon: Icons.person_outline,
        ),
      ],
    );
  }

  /// Builds the email input field
  Widget _buildEmailField(BuildContext context, ContactUsCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextFormField(
          label: AppStrings.email,
          focusNode: cubit.emailFocusNode,
          controller: cubit.emailController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          onFieldSubmitted:
              (_) => cubit.fieldFocusChange(context, cubit.emailFocusNode, cubit.messageFocusNode),
          validator: cubit.validateEmail,
          onChanged: cubit.updateEmailError,
          hintText: AppStrings.enterEmail,
          prefixIcon: Icons.email_outlined,
        ),
      ],
    );
  }

  /// Builds the message input field
  Widget _buildMessageField(BuildContext context, ContactUsCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextFormField(
          label: AppStrings.message,
          focusNode: cubit.messageFocusNode,
          controller: cubit.messageController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.multiline,
          maxLines: 5,
          onFieldSubmitted: (_) {
            cubit.messageFocusNode.unfocus();
            cubit.submitForm();
          },
          validator: cubit.validateMessage,
          onChanged: cubit.updateMessageError,
          hintText: AppStrings.enterMessage,
          // No prefix icon for multiline text area
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
            style: GoogleFonts.ptSans(fontSize: 14.sp, color: AppColors.red),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
