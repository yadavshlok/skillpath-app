import 'package:get/get.dart';
import '../models/user_model.dart';

class AuthRepository {
  // Simulate API delay
  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<Response> login(String email, String password) async {
    await _simulateDelay();

    // Mock successful login
    return Response(
      statusCode: 200,
      body: {
        'user': {
          'id': '1',
          'firstName': 'John',
          'lastName': 'Doe',
          'email': email,
          'phoneNumber': '+1 (555) 123-4567',
          'careerInterest': 'Software Developer',
          'experienceLevel': 'Intermediate',
          'createdAt': DateTime.now().toIso8601String(),
        },
        'token': 'mock_token_12345',
      },
    );
  }

  Future<Response> register(UserModel user, String password) async {
    await _simulateDelay();

    // Mock successful registration
    return Response(
      statusCode: 201,
      body: {
        'message': 'Registration successful',
        'user': user.toJson(),
      },
    );
  }

  Future<Response> logout() async {
    await _simulateDelay();
    return Response(statusCode: 200, body: {'message': 'Logged out'});
  }

  Future<Response> getUserProfile(String userId) async {
    await _simulateDelay();

    return Response(
      statusCode: 200,
      body: {
        'id': userId,
        'firstName': 'John',
        'lastName': 'Doe',
        'email': 'john.doe@example.com',
        'phoneNumber': '+1 (555) 123-4567',
        'careerInterest': 'Software Developer',
        'experienceLevel': 'Intermediate',
      },
    );
  }

  Future<Response> updateUserProfile(UserModel user) async {
    await _simulateDelay();

    return Response(
      statusCode: 200,
      body: {
        'message': 'Profile updated successfully',
        'user': user.toJson(),
      },
    );
  }
}
