import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/test_model.dart';
import '../repositories/test_repository.dart';

class TestController extends GetxController {
  final TestRepository _testRepository = TestRepository();

  final Rx<TestModel?> currentTest = Rx<TestModel?>(null);
  final RxBool isLoading = false.obs;
  final RxInt timeRemaining = 0.obs; // in seconds
  final RxString solutionCode = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      loadTestDetails(Get.arguments['testId']);
    }
  }

  Future<void> loadTestDetails(String testId) async {
    isLoading.value = true;

    final response = await _testRepository.getTestDetails(testId);

    if (response.statusCode == 200) {
      currentTest.value = TestModel.fromJson(response.body);
      timeRemaining.value = currentTest.value!.duration * 60; // Convert to seconds
      startTimer();
    } else {
      // Load dummy test
      currentTest.value = _getDummyTest();
      timeRemaining.value = currentTest.value!.duration * 60;
      startTimer();
    }

    isLoading.value = false;
  }

  void startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (timeRemaining.value > 0) {
        timeRemaining.value--;
        startTimer();
      }
    });
  }

  String get formattedTime {
    final minutes = timeRemaining.value ~/ 60;
    final seconds = timeRemaining.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> submitTest() async {
    isLoading.value = true;

    final response = await _testRepository.submitTest(
      currentTest.value!.id,
      {'solution': solutionCode.value},
    );

    isLoading.value = false;

    if (response.statusCode == 200) {
      Get.back();
      Get.snackbar(
        'Success',
        'Test submitted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        'Failed to submit test',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void saveAsDraft() {
    Get.back();
    Get.snackbar(
      'Saved',
      'Your solution has been saved as draft',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  TestModel _getDummyTest() {
    return TestModel(
      id: '1',
      title: 'Build a REST API for Task Management',
      difficulty: 'Intermediate',
      duration: 45,
      skills: ['Node.js', 'Express', 'REST API', 'Error Handling'],
      description: 'Create a RESTful API for a task management system with the following requirements:',
      requirements: [
        TestRequirement(
          number: 1,
          description: 'Implement CRUD operations for tasks (Create, Read, Update, Delete)',
        ),
        TestRequirement(
          number: 2,
          description: 'Each task should have: title, description, status (pending/in-progress/completed), and due date',
        ),
        TestRequirement(
          number: 3,
          description: 'Add endpoints for filtering tasks by status',
        ),
        TestRequirement(
          number: 4,
          description: 'Implement proper error handling and validation',
        ),
        TestRequirement(
          number: 5,
          description: 'Write the API using Node.js and Express',
        ),
      ],
      bonusPoints: [
        'Add authentication middleware',
        'Include unit tests',
        'Implement pagination for listing tasks',
      ],
    );
  }
}
