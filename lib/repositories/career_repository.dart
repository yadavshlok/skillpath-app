import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CareerRepository {
  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  Future<Response> getCareers() async {
    await _simulateDelay();

    return Response(
      statusCode: 200,
      body: {
        'careers': [
          {
            'id': '1',
            'title': 'Software Developer',
            'description': 'Build applications and software solutions',
            'icon': 'code',
            'color': '#3B82F6',
            'careersExplored': 0,
          },
          {
            'id': '2',
            'title': 'Data Scientist',
            'description': 'Analyze data and build ML models',
            'icon': 'database',
            'color': '#8B5CF6',
            'careersExplored': 0,
          },
          {
            'id': '3',
            'title': 'Cloud Engineer',
            'description': 'Design and manage cloud infrastructure',
            'icon': 'cloud',
            'color': '#10B981',
            'careersExplored': 0,
          },
          {
            'id': '4',
            'title': 'Cyber Security',
            'description': 'Protect systems and data from threats',
            'icon': 'security',
            'color': '#F59E0B',
            'careersExplored': 0,
          },
          {
            'id': '5',
            'title': 'AI/ML Engineer',
            'description': 'Develop intelligent systems and AI solutions',
            'icon': 'psychology',
            'color': '#EC4899',
            'careersExplored': 0,
          },
          {
            'id': '6',
            'title': 'Web Developer',
            'description': 'Create responsive and dynamic websites',
            'icon': 'language',
            'color': '#6366F1',
            'careersExplored': 0,
          },
        ],
      },
    );
  }

  Future<Response> getCareerDetails(String careerId) async {
    await _simulateDelay();

    return Response(
      statusCode: 200,
      body: {
        'id': careerId,
        'title': 'Software Developer',
        'description': 'Build amazing applications',
        'icon': 'code',
        'color': '#3B82F6',
      },
    );
  }
}
