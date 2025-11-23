import 'package:get/get.dart';

class TestRepository {
  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  Future<Response> getTests() async {
    await _simulateDelay();

    return Response(
      statusCode: 200,
      body: {
        'tests': [
          {
            'id': '1',
            'title': 'Build a REST API for Task Management',
            'difficulty': 'Intermediate',
            'duration': 45,
            'skills': ['Node.js', 'Express', 'REST API', 'Error Handling'],
          },
          {
            'id': '2',
            'title': 'Create a React Dashboard',
            'difficulty': 'Advanced',
            'duration': 60,
            'skills': ['React', 'TypeScript', 'Redux', 'Material-UI'],
          },
        ],
      },
    );
  }

  Future<Response> getTestDetails(String testId) async {
    await _simulateDelay();

    return Response(
      statusCode: 200,
      body: {
        'id': testId,
        'title': 'Build a REST API for Task Management',
        'difficulty': 'Intermediate',
        'duration': 45,
        'skills': ['Node.js', 'Express', 'REST API', 'Error Handling'],
        'description': 'Create a RESTful API for a task management system with the following requirements:',
        'requirements': [
          {
            'number': 1,
            'description': 'Implement CRUD operations for tasks (Create, Read, Update, Delete)',
          },
          {
            'number': 2,
            'description': 'Each task should have: title, description, status (pending/in-progress/completed), and due date',
          },
          {
            'number': 3,
            'description': 'Add endpoints for filtering tasks by status',
          },
          {
            'number': 4,
            'description': 'Implement proper error handling and validation',
          },
          {
            'number': 5,
            'description': 'Write the API using Node.js and Express',
          },
        ],
        'bonusPoints': [
          'Add authentication middleware',
          'Include unit tests',
          'Implement pagination for listing tasks',
        ],
      },
    );
  }

  Future<Response> submitTest(String testId, Map<String, dynamic> answers) async {
    await _simulateDelay();

    return Response(
      statusCode: 200,
      body: {
        'message': 'Test submitted successfully',
        'score': 85,
        'feedback': 'Great job!',
      },
    );
  }
}
