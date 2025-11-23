import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../repositories/auth_repository.dart';
import 'auth_controller.dart';

class SettingsController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final authController = Get.find<AuthController>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final RxBool emailNotifications = true.obs;
  final RxBool weeklyReports = true.obs;
  final RxBool testReminders = true.obs;
  final RxBool darkMode = false.obs;
  final RxBool isLoading = false.obs;

  final RxString selectedCareer = 'Software Developer'.obs;
  final RxString selectedExperience = 'Intermediate'.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    if (authController.currentUser.value != null) {
      final user = authController.currentUser.value!;
      firstNameController.text = user.firstName;
      lastNameController.text = user.lastName;
      emailController.text = user.email;
      phoneController.text = user.phoneNumber ?? '';
      selectedCareer.value = user.careerInterest ?? 'Software Developer';
      selectedExperience.value = user.experienceLevel ?? 'Intermediate';
    }
  }

  Future<void> saveChanges() async {
    isLoading.value = true;

    final updatedUser = UserModel(
      id: authController.currentUser.value?.id,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      phoneNumber: phoneController.text,
      careerInterest: selectedCareer.value,
      experienceLevel: selectedExperience.value,
    );

    final response = await _authRepository.updateUserProfile(updatedUser);

    isLoading.value = false;

    if (response.statusCode == 200) {
      authController.currentUser.value = updatedUser;
      Get.snackbar(
        'Success',
        'Profile updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        'Failed to update profile',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void toggleNotification(String type) {
    switch (type) {
      case 'email':
        emailNotifications.value = !emailNotifications.value;
        break;
      case 'weekly':
        weeklyReports.value = !weeklyReports.value;
        break;
      case 'test':
        testReminders.value = !testReminders.value;
        break;
    }
  }

  void toggleDarkMode() {
    darkMode.value = !darkMode.value;
    Get.changeThemeMode(darkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
