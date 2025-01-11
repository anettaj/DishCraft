import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dishcraft/Views/details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Models/recipe_data_model.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
    required this.recipe,
  });

  final RecipeDataModel recipe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(()=>DetailsPage(recipe: recipe));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        color: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 15),
          child: Row(
            spacing: 10,
            children: [
              Flexible(
                child: Hero(
                  tag: recipe.id,
                  transitionOnUserGestures: true,
                  child: CachedNetworkImage(
                    imageUrl: recipe.imageUrl,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.contain,

                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 15,
                      children: [
                        AutoSizeText(recipe.nutrition.fat,
                          style: TextTheme.of(context).displaySmall,
                        ),
                        AutoSizeText('${recipe.nutrition.calories} cal',
                          style: TextTheme.of(context).displaySmall,
                        )
                      ],
                    ),
                    AutoSizeText(
                        recipe.name,
                        style:  TextTheme.of(context).titleMedium
                    ),

                    AutoSizeText(
                        recipe.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextTheme.of(context).labelSmall
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}