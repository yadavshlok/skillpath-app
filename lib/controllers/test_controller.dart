// app/controllers/test_controller.dart
import 'package:get/get.dart';

import '../models/test_result_model.dart';
import '../routes/app_routes.dart';

class TestRequirement {
  final int number;
  final String description;

  TestRequirement({required this.number, required this.description});
}

class Test {
  final String id;
  final String title;
  final String difficulty;
  final int duration;
  final List<String> skills;
  final String description;
  final List<TestRequirement> requirements;
  final List<String> bonusPoints;

  Test({
    required this.id,
    required this.title,
    required this.difficulty,
    required this.duration,
    required this.skills,
    required this.description,
    required this.requirements,
    required this.bonusPoints,
  });
}

class TestController extends GetxController {
  final Rx<Test?> currentTest = Rx<Test?>(null);
  final RxString solutionCode = ''.obs;
  final RxBool isLoading = false.obs;
  final RxInt remainingTime = 2700.obs; // 45 minutes in seconds
  final RxString formattedTime = '45:00'.obs;

  @override
  void onInit() {
    super.onInit();
    loadTest();
    startTimer();
  }

  void loadTest() {
    final testId = Get.arguments['testId'] ?? '1';
    final careerTitle = Get.arguments['careerTitle'] ?? 'Software Developer';

    currentTest.value = getTestForCareer(careerTitle);
  }

  Test getTestForCareer(String careerTitle) {
    switch (careerTitle.toLowerCase()) {
      case 'software developer':
        return Test(
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

      case 'cyber security':
        return Test(
          id: '2',
          title: 'Security Audit & Vulnerability Assessment',
          difficulty: 'Advanced',
          duration: 60,
          skills: ['Network Security', 'Penetration Testing', 'Security Protocols', 'Threat Analysis'],
          description: 'Perform a security audit on a given system architecture with the following tasks:',
          requirements: [
            TestRequirement(
              number: 1,
              description: 'Identify potential security vulnerabilities in the system',
            ),
            TestRequirement(
              number: 2,
              description: 'Recommend security measures for each vulnerability',
            ),
            TestRequirement(
              number: 3,
              description: 'Design a secure authentication flow',
            ),
            TestRequirement(
              number: 4,
              description: 'Create a security incident response plan',
            ),
            TestRequirement(
              number: 5,
              description: 'Document best practices for secure coding',
            ),
          ],
          bonusPoints: [
            'Implement multi-factor authentication',
            'Design a security monitoring system',
            'Create automated security testing scripts',
          ],
        );

      case 'cloud engineer':
        return Test(
          id: '3',
          title: 'Cloud Infrastructure Deployment',
          difficulty: 'Intermediate',
          duration: 50,
          skills: ['AWS/Azure', 'Docker', 'Kubernetes', 'CI/CD'],
          description: 'Design and deploy a scalable cloud infrastructure with the following requirements:',
          requirements: [
            TestRequirement(
              number: 1,
              description: 'Set up a containerized application using Docker',
            ),
            TestRequirement(
              number: 2,
              description: 'Deploy the application on a cloud platform (AWS/Azure/GCP)',
            ),
            TestRequirement(
              number: 3,
              description: 'Implement auto-scaling based on traffic',
            ),
            TestRequirement(
              number: 4,
              description: 'Set up a CI/CD pipeline for automated deployments',
            ),
            TestRequirement(
              number: 5,
              description: 'Configure monitoring and logging',
            ),
          ],
          bonusPoints: [
            'Implement Infrastructure as Code (Terraform/CloudFormation)',
            'Set up disaster recovery',
            'Optimize costs',
          ],
        );

      case 'ai/ml engineer':
        return Test(
          id: '4',
          title: 'Build a Machine Learning Model',
          difficulty: 'Advanced',
          duration: 60,
          skills: ['Python', 'Machine Learning', 'Data Preprocessing', 'Model Deployment'],
          description: 'Build and deploy a machine learning model with the following requirements:',
          requirements: [
            TestRequirement(
              number: 1,
              description: 'Preprocess and clean the provided dataset',
            ),
            TestRequirement(
              number: 2,
              description: 'Train multiple models and compare their performance',
            ),
            TestRequirement(
              number: 3,
              description: 'Perform hyperparameter tuning',
            ),
            TestRequirement(
              number: 4,
              description: 'Implement cross-validation',
            ),
            TestRequirement(
              number: 5,
              description: 'Deploy the model as an API',
            ),
          ],
          bonusPoints: [
            'Implement feature engineering',
            'Add model explainability',
            'Create a monitoring dashboard',
          ],
        );

      case 'web developer':
        return Test(
          id: '5',
          title: 'Build a Responsive E-commerce Product Page',
          difficulty: 'Intermediate',
          duration: 45,
          skills: ['HTML', 'CSS', 'JavaScript', 'React', 'Responsive Design'],
          description: 'Create a fully responsive e-commerce product page with the following requirements:',
          requirements: [
            TestRequirement(
              number: 1,
              description: 'Design a product detail page with image gallery',
            ),
            TestRequirement(
              number: 2,
              description: 'Implement responsive design for mobile, tablet, and desktop',
            ),
            TestRequirement(
              number: 3,
              description: 'Add product variants selection (size, color)',
            ),
            TestRequirement(
              number: 4,
              description: 'Create add to cart functionality',
            ),
            TestRequirement(
              number: 5,
              description: 'Optimize for performance and accessibility',
            ),
          ],
          bonusPoints: [
            'Add product zoom functionality',
            'Implement lazy loading for images',
            'Add animations and transitions',
          ],
        );

      case 'data scientist':
        return Test(
          id: '6',
          title: 'Data Analysis & Visualization Project',
          difficulty: 'Intermediate',
          duration: 50,
          skills: ['Python', 'Pandas', 'Data Visualization', 'Statistical Analysis'],
          description: 'Perform comprehensive data analysis on a given dataset with the following tasks:',
          requirements: [
            TestRequirement(
              number: 1,
              description: 'Perform exploratory data analysis (EDA)',
            ),
            TestRequirement(
              number: 2,
              description: 'Handle missing values and outliers',
            ),
            TestRequirement(
              number: 3,
              description: 'Create meaningful visualizations',
            ),
            TestRequirement(
              number: 4,
              description: 'Perform statistical tests and hypothesis testing',
            ),
            TestRequirement(
              number: 5,
              description: 'Generate insights and recommendations',
            ),
          ],
          bonusPoints: [
            'Build an interactive dashboard',
            'Perform time series analysis',
            'Create automated reporting',
          ],
        );

      default:
        return Test(
          id: '1',
          title: 'General Technical Assessment',
          difficulty: 'Intermediate',
          duration: 45,
          skills: ['Problem Solving', 'Critical Thinking', 'Technical Skills'],
          description: 'Complete the general technical assessment:',
          requirements: [
            TestRequirement(
              number: 1,
              description: 'Solve algorithmic problems',
            ),
            TestRequirement(
              number: 2,
              description: 'Demonstrate system design knowledge',
            ),
            TestRequirement(
              number: 3,
              description: 'Write clean, maintainable code',
            ),
          ],
          bonusPoints: [
            'Optimize for performance',
            'Add comprehensive documentation',
          ],
        );
    }
  }

  void startTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (remainingTime.value > 0) {
        remainingTime.value--;
        int minutes = remainingTime.value ~/ 60;
        int seconds = remainingTime.value % 60;
        formattedTime.value = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        startTimer();
      }
    });
  }

  void saveAsDraft() {
    Get.snackbar(
      'Draft Saved',
      'Your solution has been saved',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Update the submitTest method in test_controller.dart

  void submitTest() {
    isLoading.value = true;

    Future.delayed(Duration(seconds: 1), () {
      isLoading.value = false;

      // Generate mock feedback based on career
      final TestResult result = _generateTestResult();

      // Navigate to feedback screen
      Get.offNamed(Routes.TEST_FEEDBACK, arguments: {
        'result': result,
      });
    });
  }

  TestResult _generateTestResult() {
    final careerTitle = Get.arguments['careerTitle'] ?? 'Software Developer';

    // Mock scoring - in real app, this would come from backend
    final score = 75 + (DateTime.now().millisecond % 20); // Random 75-95

    return TestResult(
      testId: '1',
      careerTitle: careerTitle,
      score: score,
      totalScore: 100,
      userSolution: solutionCode.value.isEmpty
          ? '// No solution provided'
          : solutionCode.value,
      strengths: _getStrengthsForCareer(careerTitle),
      areasToImprove: _getAreasToImproveForCareer(careerTitle),
      skillsToDevelop: _getSkillsToDevForCareer(careerTitle),
      feedback: _getFeedbackForCareer(careerTitle, score),
      submittedAt: DateTime.now(),
    );
  }

  List<String> _getStrengthsForCareer(String career) {
    switch (career.toLowerCase()) {
      case 'software developer':
        return [
          'Strong understanding of RESTful API design principles',
          'Good error handling implementation',
          'Clean and readable code structure',
        ];
      case 'cyber security':
        return [
          'Excellent security protocol knowledge',
          'Thorough vulnerability assessment',
          'Good understanding of encryption methods',
        ];
      case 'cloud engineer':
        return [
          'Solid containerization concepts',
          'Good understanding of cloud architecture',
          'Effective use of CI/CD practices',
        ];
      default:
        return [
          'Good problem-solving approach',
          'Clear code organization',
          'Effective implementation strategy',
        ];
    }
  }

  List<String> _getAreasToImproveForCareer(String career) {
    switch (career.toLowerCase()) {
      case 'software developer':
        return [
          'Add more comprehensive input validation',
          'Implement better error messages',
          'Consider edge cases in your solution',
        ];
      case 'cyber security':
        return [
          'Include more detailed threat modeling',
          'Expand on incident response procedures',
          'Add more security testing scenarios',
        ];
      case 'cloud engineer':
        return [
          'Optimize resource allocation',
          'Add more monitoring metrics',
          'Improve disaster recovery plan',
        ];
      default:
        return [
          'Add more code comments',
          'Consider performance optimization',
          'Improve test coverage',
        ];
    }
  }

  List<String> _getSkillsToDevForCareer(String career) {
    switch (career.toLowerCase()) {
      case 'software developer':
        return [
          'Authentication & Authorization',
          'Unit Testing',
          'API Documentation',
          'Database Optimization',
        ];
      case 'cyber security':
        return [
          'Advanced Penetration Testing',
          'Security Automation',
          'Compliance Standards',
          'Forensics',
        ];
      case 'cloud engineer':
        return [
          'Kubernetes',
          'Terraform',
          'Cost Optimization',
          'Multi-cloud Strategy',
        ];
      default:
        return [
          'Advanced Algorithms',
          'System Design',
          'Code Review',
          'Documentation',
        ];
    }
  }

  String _getFeedbackForCareer(String career, int score) {
    if (score >= 90) {
      return 'Excellent work! You demonstrated strong proficiency in $career. Your solution shows deep understanding of the concepts and best practices. Keep up the great work!';
    } else if (score >= 70) {
      return 'Good job! You have a solid understanding of $career fundamentals. With some practice on the areas mentioned above, you\'ll be ready for more advanced challenges.';
    } else if (score >= 50) {
      return 'Fair attempt! You show basic understanding of $career concepts. Focus on the areas to improve and skills to develop to strengthen your foundation.';
    } else {
      return 'Keep learning! $career requires practice and dedication. Review the fundamentals and work on the recommended skills to build a stronger foundation.';
    }
  }



  @override
  void onClose() {
    super.onClose();
  }
}
