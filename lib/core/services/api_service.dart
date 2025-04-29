import 'package:injectable/injectable.dart';

/// ApiService provides methods for making API requests
@singleton
class ApiService {
  /// Simulates sending contact form data to a backend
  ///
  /// Returns a Future that completes after a delay to simulate network request
  Future<bool> submitContactForm({
    required String name,
    required String email,
    required String message,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // For demo purposes, always return success
    // In a real app, this would make an HTTP request and handle errors
    return true;
  }
}
