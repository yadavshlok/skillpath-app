// app/controllers/career_assessment_controller.dart
import 'package:get/get.dart';

class Skill {
  final String id;
  final String name;
  final RxDouble level;

  Skill({
    required this.id,
    required this.name,
    double level = 0,
  }) : level = level.obs;
}

class CareerAssessmentController extends GetxController {
  final RxList<Skill> skills = <Skill>[].obs;
  final RxString selectedCareer = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Get career title from arguments
    final careerTitle = Get.arguments['title'] ?? 'Software Developer';
    selectedCareer.value = careerTitle;
    loadSkillsForCareer(careerTitle);
  }

  void loadSkillsForCareer(String careerTitle) {
    switch (careerTitle.toLowerCase()) {
      case 'software developer':
        skills.value = [
          Skill(id: '1', name: 'Frontend Development', level: 0),
          Skill(id: '2', name: 'Backend Development', level: 0),
          Skill(id: '3', name: 'Database Management', level: 0),
          Skill(id: '4', name: 'API Development', level: 0),
          Skill(id: '5', name: 'Version Control (Git)', level: 0),
          Skill(id: '6', name: 'Testing & Debugging', level: 0),
        ];
        break;

      case 'cyber security':
        skills.value = [
          Skill(id: '1', name: 'Network Security', level: 0),
          Skill(id: '2', name: 'Ethical Hacking', level: 0),
          Skill(id: '3', name: 'Cryptography', level: 0),
          Skill(id: '4', name: 'Security Protocols', level: 0),
          Skill(id: '5', name: 'Threat Analysis', level: 0),
          Skill(id: '6', name: 'Penetration Testing', level: 0),
        ];
        break;

      case 'cloud engineer':
        skills.value = [
          Skill(id: '1', name: 'AWS/Azure/GCP', level: 0),
          Skill(id: '2', name: 'Container Orchestration', level: 0),
          Skill(id: '3', name: 'CI/CD Pipelines', level: 0),
          Skill(id: '4', name: 'Infrastructure as Code', level: 0),
          Skill(id: '5', name: 'Cloud Security', level: 0),
          Skill(id: '6', name: 'Serverless Architecture', level: 0),
        ];
        break;

      case 'ai/ml engineer':
        skills.value = [
          Skill(id: '1', name: 'Machine Learning', level: 0),
          Skill(id: '2', name: 'Deep Learning', level: 0),
          Skill(id: '3', name: 'Python & Libraries', level: 0),
          Skill(id: '4', name: 'Data Preprocessing', level: 0),
          Skill(id: '5', name: 'Model Deployment', level: 0),
          Skill(id: '6', name: 'Neural Networks', level: 0),
        ];
        break;

      case 'web developer':
        skills.value = [
          Skill(id: '1', name: 'HTML & CSS', level: 0),
          Skill(id: '2', name: 'JavaScript', level: 0),
          Skill(id: '3', name: 'React/Vue/Angular', level: 0),
          Skill(id: '4', name: 'Responsive Design', level: 0),
          Skill(id: '5', name: 'Web Performance', level: 0),
          Skill(id: '6', name: 'Cross-browser Testing', level: 0),
        ];
        break;

      case 'data scientist':
        skills.value = [
          Skill(id: '1', name: 'Statistical Analysis', level: 0),
          Skill(id: '2', name: 'Python/R Programming', level: 0),
          Skill(id: '3', name: 'Data Visualization', level: 0),
          Skill(id: '4', name: 'SQL & Databases', level: 0),
          Skill(id: '5', name: 'Machine Learning', level: 0),
          Skill(id: '6', name: 'Big Data Tools', level: 0),
        ];
        break;

      default:
      // Default skills if career not matched
        skills.value = [
          Skill(id: '1', name: 'Problem Solving', level: 0),
          Skill(id: '2', name: 'Critical Thinking', level: 0),
          Skill(id: '3', name: 'Communication', level: 0),
          Skill(id: '4', name: 'Technical Knowledge', level: 0),
          Skill(id: '5', name: 'Teamwork', level: 0),
        ];
    }
  }

  void updateSkillLevel(String skillId, double level) {
    final skill = skills.firstWhere((s) => s.id == skillId);
    skill.level.value = level;
  }

  bool isAllSkillsRated() {
    return skills.every((skill) => skill.level.value > 0);
  }

  Map<String, dynamic> getSkillsData() {
    return {
      'career': selectedCareer.value,
      'skills': skills.map((skill) => {
        'name': skill.name,
        'level': skill.level.value,
      }).toList(),
    };
  }

  @override
  void onClose() {
    super.onClose();
  }
}
