// app/data/models/test_result_model.dart
class TestResult {
  final String testId;
  final String careerTitle;
  final int score;
  final int totalScore;
  final String userSolution;
  final List<String> strengths;
  final List<String> areasToImprove;
  final List<String> skillsToDevelop;
  final String feedback;
  final DateTime submittedAt;

  TestResult({
    required this.testId,
    required this.careerTitle,
    required this.score,
    required this.totalScore,
    required this.userSolution,
    required this.strengths,
    required this.areasToImprove,
    required this.skillsToDevelop,
    required this.feedback,
    required this.submittedAt,
  });

  double get percentage => (score / totalScore) * 100;

  String get grade {
    if (percentage >= 90) return 'A+';
    if (percentage >= 80) return 'A';
    if (percentage >= 70) return 'B';
    if (percentage >= 60) return 'C';
    if (percentage >= 50) return 'D';
    return 'F';
  }
}
