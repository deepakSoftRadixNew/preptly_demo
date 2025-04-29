import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/services/api_service.dart';
import 'contact_us_state.dart';

/// ContactUsCubit manages the state and logic for the contact form
@injectable
class ContactUsCubit extends Cubit<ContactUsState> {
  final ApiService _apiService;

  // Form controllers
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  // Focus nodes for each field
  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final messageFocusNode = FocusNode();

  // Validation constants
  static const int minNameLength = 2;
  static const int minMessageWords = 10;

  // Emoji regex pattern to detect emojis
  static final RegExp _emojiRegExp = RegExp(
    r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])',
  );

  /// Creates a ContactUsCubit with injected dependencies
  ContactUsCubit(this._apiService) : super(const ContactUsState());

  // Clean up resources
  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();

    nameFocusNode.dispose();
    emailFocusNode.dispose();
    messageFocusNode.dispose();

    return super.close();
  }

  // Move focus to the next field
  void fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  // Check if text contains emojis
  bool _containsEmoji(String text) {
    return _emojiRegExp.hasMatch(text);
  }

  // Validate name field
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.nameRequired;
    }

    // Check for emojis
    if (_containsEmoji(value)) {
      return AppStrings.emojiNotAllowed;
    }

    if (value.length < minNameLength) {
      return AppStrings.nameTooShort;
    }

    // Check for invalid characters
    bool hasInvalidChars = false;
    for (int i = 0; i < value.length; i++) {
      String char = value[i];
      if (!RegExp("[a-zA-Z .\\-']").hasMatch(char)) {
        hasInvalidChars = true;
        break;
      }
    }

    if (hasInvalidChars) {
      return AppStrings.nameInvalidChars;
    }

    return null;
  }

  // Validate email field
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emailRequired;
    }

    // Check for emojis
    if (_containsEmoji(value)) {
      return AppStrings.emojiNotAllowed;
    }

    // Simple email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return AppStrings.invalidEmail;
    }

    return null;
  }

  // Validate message field
  String? validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.messageRequired;
    }

    // Check for emojis
    if (_containsEmoji(value)) {
      return AppStrings.emojiNotAllowed;
    }

    final wordCount = value.split(' ').where((word) => word.trim().isNotEmpty).length;

    if (wordCount < minMessageWords) {
      return AppStrings.messageTooShort;
    }

    return null;
  }

  // Submit form
  Future<void> submitForm() async {
    // Change state to validating
    emit(state.copyWith(status: ContactFormStatus.validating));

    if (formKey.currentState?.validate() ?? false) {
      // Start submission process
      emit(state.copyWith(status: ContactFormStatus.submitting, isLoading: true));

      try {
        // Submit form to backend
        final success = await _apiService.submitContactForm(
          name: nameController.text,
          email: emailController.text,
          message: messageController.text,
        );

        if (success) {
          // Update state after successful submission
          emit(state.copyWith(status: ContactFormStatus.success, isLoading: false));

          // Reset form fields
          _resetFormFields();
        } else {
          // Handle api returned failure
          emit(
            state.copyWith(
              status: ContactFormStatus.failure,
              isLoading: false,
              errorMessage: 'Failed to submit form. Please try again.',
            ),
          );
        }
      } catch (e) {
        // Handle exception
        emit(
          state.copyWith(
            status: ContactFormStatus.failure,
            isLoading: false,
            errorMessage: 'An error occurred: ${e.toString()}',
          ),
        );
      }
    }
  }

  // Reset form fields
  void _resetFormFields() {
    nameController.clear();
    emailController.clear();
    messageController.clear();
  }

  // Reset form to initial state
  void resetForm() {
    emit(const ContactUsState());
  }

  // Update field errors in state for real-time validation
  void updateNameError(String? value) {
    final error = validateName(value);
    emit(state.copyWith(nameError: error));
  }

  void updateEmailError(String? value) {
    final error = validateEmail(value);
    emit(state.copyWith(emailError: error));
  }

  void updateMessageError(String? value) {
    final error = validateMessage(value);
    emit(state.copyWith(messageError: error));
  }
}
