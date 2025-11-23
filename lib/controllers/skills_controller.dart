import 'package:get/get.dart';
import '../models/skill_model.dart';
import '../repositories/skill_repository.dart';

class SkillsController extends GetxController {
  final SkillRepository _skillRepository = SkillRepository();

  final RxList<SkillModel> technicalSkills = <SkillModel>[].obs;
  final RxList<SkillModel> softSkills = <SkillModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxDouble overallSkillLevel = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSkills();
  }

  Future<void> fetchSkills() async {
    isLoading.value = true;

    final response = await _skillRepository.getSkills();

    if (response.statusCode == 200) {
      final allSkills = (response.body['skills'] as List)
          .map((json) => SkillModel.fromJson(json))
          .toList();

      technicalSkills.value = allSkills
          .where((skill) => skill.category == 'technical')
          .toList();

      softSkills.value = allSkills
          .where((skill) => skill.category == 'soft')
          .toList();
    } else {
      _loadDummySkills();
    }

    calculateOverallLevel();
    isLoading.value = false;
  }

  void updateSkillLevel(String skillId, double newLevel) {
    final techIndex = technicalSkills.indexWhere((s) => s.id == skillId);
    if (techIndex != -1) {
      technicalSkills[techIndex] = SkillModel(
        id: skillId,
        name: technicalSkills[techIndex].name,
        level: newLevel,
        category: 'technical',
      );
    }

    final softIndex = softSkills.indexWhere((s) => s.id == skillId);
    if (softIndex != -1) {
      softSkills[softIndex] = SkillModel(
        id: skillId,
        name: softSkills[softIndex].name,
        level: newLevel,
        category: 'soft',
      );
    }

    calculateOverallLevel();
  }

  void calculateOverallLevel() {
    final allSkills = [...technicalSkills, ...softSkills];
    if (allSkills.isEmpty) {
      overallSkillLevel.value = 0.0;
      return;
    }

    final total = allSkills.fold(0.0, (sum, skill) => sum + skill.level);
    overallSkillLevel.value = total / allSkills.length;
  }

  Future<void> saveSkills() async {
    isLoading.value = true;

    final allSkills = [...technicalSkills, ...softSkills];
    final response = await _skillRepository.updateSkills(allSkills);

    isLoading.value = false;

    if (response.statusCode == 200) {
      Get.snackbar(
        'Success',
        'Skills updated successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _loadDummySkills() {
    technicalSkills.value = [
      SkillModel(id: '1', name: 'Frontend Development', level: 3.0, category: 'technical'),
      SkillModel(id: '2', name: 'Backend Development', level: 2.0, category: 'technical'),
      SkillModel(id: '3', name: 'Database Management', level: 3.0, category: 'technical'),
      SkillModel(id: '4', name: 'DevOps & Cloud', level: 2.0, category: 'technical'),
    ];

    softSkills.value = [
      SkillModel(id: '5', name: 'Problem Solving', level: 4.0, category: 'soft'),
      SkillModel(id: '6', name: 'Communication', level: 4.0, category: 'soft'),
      SkillModel(id: '7', name: 'Teamwork', level: 4.0, category: 'soft'),
      SkillModel(id: '8', name: 'Leadership', level: 3.0, category: 'soft'),
    ];
  }
}
