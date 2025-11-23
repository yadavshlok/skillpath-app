class SkillModel {
  final String id;
  final String name;
  final double level; // 0-5
  final String category; // technical or soft

  SkillModel({
    required this.id,
    required this.name,
    required this.level,
    required this.category,
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      id: json['id'],
      name: json['name'],
      level: (json['level'] ?? 0).toDouble(),
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'level': level,
      'category': category,
    };
  }
}
