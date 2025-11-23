class TestModel {
  final String id;
  final String title;
  final String difficulty;
  final int duration; // in minutes
  final List<String> skills;
  final String description;
  final List<TestRequirement> requirements;
  final List<String> bonusPoints;

  TestModel({
    required this.id,
    required this.title,
    required this.difficulty,
    required this.duration,
    required this.skills,
    required this.description,
    required this.requirements,
    this.bonusPoints = const [],
  });

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      id: json['id'],
      title: json['title'],
      difficulty: json['difficulty'],
      duration: json['duration'],
      skills: List<String>.from(json['skills'] ?? []),
      description: json['description'],
      requirements: (json['requirements'] as List)
          .map((e) => TestRequirement.fromJson(e))
          .toList(),
      bonusPoints: List<String>.from(json['bonusPoints'] ?? []),
    );
  }
}

class TestRequirement {
  final int number;
  final String description;

  TestRequirement({
    required this.number,
    required this.description,
  });

  factory TestRequirement.fromJson(Map<String, dynamic> json) {
    return TestRequirement(
      number: json['number'],
      description: json['description'],
    );
  }
}
