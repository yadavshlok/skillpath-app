import 'package:flutter/material.dart';

class CareerModel {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final int careersExplored;

  CareerModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    this.careersExplored = 0,
  });

  factory CareerModel.fromJson(Map<String, dynamic> json) {
    return CareerModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      icon: _getIconFromString(json['icon']),
      color: Color(int.parse(json['color'].replaceAll('#', '0xFF'))),
      careersExplored: json['careersExplored'] ?? 0,
    );
  }

  static IconData _getIconFromString(String iconName) {
    switch (iconName) {
      case 'code':
        return Icons.code;
      case 'database':
        return Icons.storage;
      case 'cloud':
        return Icons.cloud;
      case 'security':
        return Icons.security;
      case 'psychology':
        return Icons.psychology;
      case 'language':
        return Icons.language;
      default:
        return Icons.work;
    }
  }
}
