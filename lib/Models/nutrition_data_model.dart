class NutritionDataModel {
  final String calories;
  final String fat;
  final String protein;
  final String carbs;
  final String fiber;

  NutritionDataModel({
    required this.calories,
    required this.fat,
    required this.protein,
    required this.carbs,
    required this.fiber,
  });

  factory NutritionDataModel.fromJson(Map<String, dynamic> json) {
    return NutritionDataModel(
      calories: json['calories'],
      fat: json['fat'],
      protein: json['protein'],
      carbs: json['carbs'],
      fiber: json['fiber'],
    );
  }

}
