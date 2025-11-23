import 'package:get/get.dart';

class SkillRepository {
  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  Future<Response> getSkills() async {
    await _simulateDelay();

    return Response(
      statusCode: 200,
      body: {
        'skills': [
          // Technical Skills
          {
            'id': '1',
            'name': 'Frontend Development',
            'level': 3.0,
            'category': 'technical',
          },
          {
            'id': '2',
            'name': 'Backend Development',
            'level': 2.0,
            'category': 'technical',
          },
          {
            'id': '3',
            'name': 'Database Management',
            'level': 3.0,
            'category': 'technical',
          },
          {
            'id': '4',
            'name': 'DevOps & Cloud',
            'level': 2.0,
            'category': 'technical',
          },
          // Soft Skills
          {
            'id': '5',
            'name': 'Problem Solving',
            'level': 4.0,
            'category': 'soft',
          },
          {
            'id': '6',
            'name': 'Communication',
            'level': 4.0,
            'category': 'soft',
          },
          {
            'id': '7',
            'name': 'Teamwork',
            'level': 4.0,
            'category': 'soft',
          },
          {
            'id': '8',
            'name': 'Leadership',
            'level': 3.0,
            'category': 'soft',
          },
        ],
      },
    );
  }

  Future<Response> updateSkills(List skills) async {
    await _simulateDelay();

    return Response(
      statusCode: 200,
      body: {
        'message': 'Skills updated successfully',
        'skills': skills,
      },
    );
  }
}
