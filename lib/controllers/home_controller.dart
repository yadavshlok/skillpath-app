import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../models/career_model.dart';
import '../repositories/career_repository.dart';

class HomeController extends GetxController {
  final CareerRepository _careerRepository = CareerRepository();

  final RxList<CareerModel> careers = <CareerModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxInt careersExplored = 3.obs;
  final RxInt skillsAssessed = 12.obs;
  final RxInt testsCompleted = 5.obs;
  final RxInt selectedNavIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCareers();
  }

  Future<void> fetchCareers() async {
    isLoading.value = true;

    final response = await _careerRepository.getCareers();

    if (response.statusCode == 200) {
      careers.value = (response.body['careers'] as List)
          .map((json) => CareerModel.fromJson(json))
          .toList();
    } else {
      // Use dummy data if API fails
      careers.value = _getDummyCareers();
    }

    isLoading.value = false;
  }

  void changeNavIndex(int index) {
    selectedNavIndex.value = index;
  }

  List<CareerModel> _getDummyCareers() {
    return [
      CareerModel(
        id: '1',
        title: 'Software Developer',
        description: 'Build applications and software solutions',
        icon: Icons.code,
        color: AppColors.softwareBlue,
      ),
      CareerModel(
        id: '2',
        title: 'Data Scientist',
        description: 'Analyze data and build ML models',
        icon: Icons.storage,
        color: AppColors.dataPurple,
      ),
      CareerModel(
        id: '3',
        title: 'Cloud Engineer',
        description: 'Design and manage cloud infrastructure',
        icon: Icons.cloud,
        color: AppColors.cloudGreen,
      ),
      CareerModel(
        id: '4',
        title: 'Cyber Security',
        description: 'Protect systems and data from threats',
        icon: Icons.security,
        color: AppColors.securityOrange,
      ),
      CareerModel(
        id: '5',
        title: 'AI/ML Engineer',
        description: 'Develop intelligent systems and AI solutions',
        icon: Icons.psychology,
        color: AppColors.aiPink,
      ),
      CareerModel(
        id: '6',
        title: 'Web Developer',
        description: 'Create responsive and dynamic websites',
        icon: Icons.language,
        color: AppColors.webIndigo,
      ),
    ];
  }
}
