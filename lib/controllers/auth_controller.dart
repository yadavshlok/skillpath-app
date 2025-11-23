import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../repositories/auth_repository.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  // Login form
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  // Signup form
  final signupNameController = TextEditingController();
  final signupEmailController = TextEditingController();
  final signupPasswordController = TextEditingController();
  final signupConfirmPasswordController = TextEditingController();

  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    if (loginEmailController.text.isEmpty ||
        loginPasswordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    final response = await _authRepository.login(
      loginEmailController.text,
      loginPasswordController.text,
    );

    isLoading.value = false;

    if (response.statusCode == 200) {
      currentUser.value = UserModel.fromJson(response.body['user']);
      Get.offAllNamed(Routes.HOME);
      Get.snackbar(
        'Success',
        'Login successful',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        response.body['message'] ?? 'Login failed',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> register() async {
    if (signupNameController.text.isEmpty ||
        signupEmailController.text.isEmpty ||
        signupPasswordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (signupPasswordController.text !=
        signupConfirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    final names = signupNameController.text.split(' ');
    final user = UserModel(
      firstName: names.first,
      lastName: names.length > 1 ? names.sublist(1).join(' ') : '',
      email: signupEmailController.text,
    );

    final response = await _authRepository.register(
      user,
      signupPasswordController.text,
    );

    isLoading.value = false;

    if (response.statusCode == 201 || response.statusCode == 200) {
      Get.offAllNamed(Routes.LOGIN);
      Get.snackbar(
        'Success',
        'Registration successful. Please login.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        response.body['message'] ?? 'Registration failed',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> logout() async {
    isLoading.value = true;
    await _authRepository.logout();
    isLoading.value = false;

    currentUser.value = null;
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onClose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    signupNameController.dispose();
    signupEmailController.dispose();
    signupPasswordController.dispose();
    signupConfirmPasswordController.dispose();
    super.onClose();
  }
}
