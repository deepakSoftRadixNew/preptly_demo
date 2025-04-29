class AppStrings {
  // App Common Strings
  static const String appName = 'Preptly';

  // Button Texts
  static const String submit = 'Submit';
  static const String cancel = 'Cancel';
  static const String ok = 'OK';

  // Contact Us Screen
  static const String contactUs = 'Contact Us';
  static const String name = 'Name';
  static const String email = 'Email';
  static const String message = 'Message';
  static const String enterName = 'Enter your name';
  static const String enterEmail = 'Enter your email';
  static const String enterMessage = 'Enter your message';
  static const String formSubmittedSuccessfully =
      'Your message has been sent successfully. We will get back to you soon.';

  // Validation Messages
  static const String nameRequired = 'Name is required';
  static const String nameTooShort = 'Name must be at least 2 characters';
  static const String nameInvalidChars = 'Name contains invalid characters';
  static const String emailRequired = 'Email is required';
  static const String invalidEmail = 'Please enter a valid email address';
  static const String messageRequired = 'Message is required';
  static const String messageTooShort = 'Message must be at least 10 characters';
  static const String emojiNotAllowed = 'Emojis are not allowed';

  // API & Network
  static const String contactUsEndpoint = '/contact-us';

  // Comment Placeholders
  static const String validInput = 'Valid input';

  // Form Keys
  static const String contactUsFormKey = 'contact_us_form';

  // Field Names for API
  static const String fieldName = 'name';
  static const String fieldEmail = 'email';
  static const String fieldMessage = 'message';

  // Code Comments
  static const String validateNameComment = 'Validates the name field';
  static const String validateEmailComment = 'Validates the email field with format checking';
  static const String validateMessageComment = 'Validates the message field';
  static const String formSubmissionComment = 'Handles the form submission process';
  static const String simulateBackendComment = 'Simulates sending form data to backend';
  static const String resetFormComment = 'Resets the form submission state to show the form again';
}
