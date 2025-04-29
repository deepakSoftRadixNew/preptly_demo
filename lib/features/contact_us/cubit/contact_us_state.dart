import 'package:equatable/equatable.dart';

/// Enum representing the various states of the contact form
enum ContactFormStatus {
  /// Initial state with empty form
  initial,

  /// Form is being validated
  validating,

  /// Form submission is in progress
  submitting,

  /// Form was submitted successfully
  success,

  /// Form submission failed
  failure,
}

/// State class for the ContactUs form
class ContactUsState extends Equatable {
  /// Current status of the form
  final ContactFormStatus status;

  /// Whether the form is currently loading (submitting)
  final bool isLoading;

  /// Error messages for form fields
  final String? nameError;
  final String? emailError;
  final String? messageError;

  /// Error message in case of submission failure
  final String? errorMessage;

  /// Creates a ContactUsState
  const ContactUsState({
    this.status = ContactFormStatus.initial,
    this.isLoading = false,
    this.nameError,
    this.emailError,
    this.messageError,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, isLoading, nameError, emailError, messageError, errorMessage];

  /// Creates a copy of this state with the given fields replaced
  ContactUsState copyWith({
    ContactFormStatus? status,
    bool? isLoading,
    String? nameError,
    String? Function()? nameErrorGetter,
    String? emailError,
    String? Function()? emailErrorGetter,
    String? messageError,
    String? Function()? messageErrorGetter,
    String? errorMessage,
  }) {
    return ContactUsState(
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
      nameError: nameErrorGetter != null ? nameErrorGetter() : (nameError ?? this.nameError),
      emailError: emailErrorGetter != null ? emailErrorGetter() : (emailError ?? this.emailError),
      messageError:
          messageErrorGetter != null ? messageErrorGetter() : (messageError ?? this.messageError),
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  /// Checks if form is in initial state
  bool get isInitial => status == ContactFormStatus.initial;

  /// Checks if form is being validated
  bool get isValidating => status == ContactFormStatus.validating;

  /// Checks if form is being submitted
  bool get isSubmitting => status == ContactFormStatus.submitting;

  /// Checks if form was submitted successfully
  bool get isFormSubmitted => status == ContactFormStatus.success;

  /// Checks if form submission failed
  bool get isFailure => status == ContactFormStatus.failure;

  /// Checks if form has any validation errors
  bool get hasErrors => nameError != null || emailError != null || messageError != null;
}
