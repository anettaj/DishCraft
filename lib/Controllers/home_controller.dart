import 'dart:convert';
import 'package:dishcraft/Models/recipe_data_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class Category {
  final String name;
  final String icon;

  Category(this.name, this.icon);
}

class HomeController extends GetxController {
  var isLoading = false.obs;
  var selectedCategory = ''.obs;
  var categories = <Category>[
    Category('Popular', '🔥'),
    Category('Salad', '🥗'),
    Category('Breakfast', '🥪'),
    Category('Soup', '🥣'),
  ].obs;

  var allRecipes = <RecipeDataModel>[].obs;
  var filteredRecipes = <RecipeDataModel>[].obs;
  var errorMessage=''.obs;
  @override
  void onInit() {
    super.onInit();
    fetchPopularData();
  }

  Future<void> fetchPopularData() async {
    const url = 'https://anettaj.in/Datasets/RecipesApi/popular.json';
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        // Map the raw data to RecipeDataModel
        allRecipes.value = data.map((item) => RecipeDataModel.fromJson(item)).toList();
        filterRecipes();
      } else {
        errorMessage.value = 'There seems to be some problem';
      }
    } catch (e) {
      errorMessage.value = 'There seems to be some problem';
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
    filterRecipes();
  }

  void filterRecipes() {
    if (selectedCategory.value.isEmpty || selectedCategory.value == 'Popular') {
      filteredRecipes.value = allRecipes;
    } else {
      filteredRecipes.value = allRecipes
          .where((recipe) => recipe.category == selectedCategory.value)
          .toList();
    }
  }

}