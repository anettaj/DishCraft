import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/home_controller.dart';
import '../Utils/colors.dart';
import 'Widget/recipe_card.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedCategory = "Popular";
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    double W = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: W * 0.8,
            margin: const EdgeInsets.only(left: 25,top: 40),
            child: AutoSizeText(
              "What do you want to cook today?",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),

          // Categories
          Obx(() {
            if (homeController.categories.isEmpty) {
              return const SizedBox.shrink();
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 25,top: 20,bottom: 20),
              child: Row(
                spacing: 15,
                children: homeController.categories.map((category) {
                  return categoryButton(category);
                }).toList(),
              ),
            );
          }),

          // Recipes List
          Expanded(
            child: Obx(() {
              if (homeController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              // Filter recipes by selected category
              final filteredRecipes = selectedCategory == "Popular"
                  ? homeController.allRecipes
                  : homeController.allRecipes
                  .where((recipe) => recipe.type== selectedCategory)
                  .toList();

              if (filteredRecipes.isEmpty) {
                return Center(
                  child: Text(
                    "No recipes available.",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                );
              }

              return ListView.builder(
                itemCount: filteredRecipes.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final recipe = filteredRecipes[index];

                  precacheImage(NetworkImage(recipe.imageUrl), context);

                  return RecipeCard(recipe: recipe);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget categoryButton(Category category) {
    final bool isSelected = selectedCategory == category.name;
    return InkWell(
      onTap: () {
        setState(() {
          selectedCategory = category.name;
        });
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? lightGoldenRod : grey,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '${category.icon} ${category.name}',
          style: TextStyle(
            color: isSelected ? lightGoldenRod : grey,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
