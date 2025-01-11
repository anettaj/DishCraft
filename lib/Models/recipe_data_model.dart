import 'package:dishcraft/Models/storage_data_model.dart';

import 'nutrition_data_model.dart';

class RecipeDataModel {
  final String id;
  final String name;
  final String description;
  final List<Map<String, String>> ingredients; // Adjusted to match the example
  final List<String> steps;
  final String time;
  final String imageUrl;
  final String type;
  final String category;
  final String difficulty;
  final String servingSize;
  final NutritionDataModel nutrition;
  final List<String> equipment;
  final StorageDataModel storage;
  final String occasion;

  RecipeDataModel({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.steps,
    required this.time,
    required this.imageUrl,
    required this.type,
    required this.category,
    required this.difficulty,
    required this.servingSize,
    required this.nutrition,
    required this.equipment,
    required this.storage,
    required this.occasion,
  });

  // Add this factory constructor
  factory RecipeDataModel.fromJson(Map<String, dynamic> json) {
    return RecipeDataModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((item) => Map<String, String>.from(item))
          .toList(),
      steps: List<String>.from(json['steps'] ?? []),
      time: json['time'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      type: json['type'] ?? '',
      category: json['category'] ?? '',
      difficulty: json['difficulty'] ?? '',
      servingSize: json['servingSize'] ?? '',
      nutrition: NutritionDataModel.fromJson(json['nutrition'] ?? {}),
      equipment: List<String>.from(json['equipment'] ?? []),
      storage: StorageDataModel.fromJson(json['storage'] ?? {}),
      occasion: json['occasion'] ?? '',
    );
  }
}
