import 'package:cached_network_image/cached_network_image.dart';
import 'package:dishcraft/Models/recipe_data_model.dart';
import 'package:dishcraft/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.recipe});
  final RecipeDataModel recipe;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  double _sheetProgress = 0.2;
  int _currentStep = 0;
  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: bgColor,
      body:  Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            top: 50,
            left: 0,
            right: 0,
            height: screenHeight * (0.9 - _sheetProgress),
            child: SizedBox(
              height: screenHeight * (0.9 - _sheetProgress),
              child: Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildAppBar(),
                  buildImage(),
                  buildNurtitionInfoContainer(),
                ],
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.1,
            minChildSize: 0.1,
            maxChildSize: 0.6,
            builder: (BuildContext context, ScrollController scrollController) {
              return NotificationListener<DraggableScrollableNotification>(
                onNotification: (notification) {
                  setState(() {
                    _sheetProgress = notification.extent;
                  });
                  return true;
                },
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.only(top: 20),
                    controller: scrollController,
                    children: [
                      Center(
                        child: Container(
                          width: 50,
                          height: 5,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      buildSectionTitle('Ingredients'),

                      buildIngredientsSection(),
                      Stepper(
                        physics: ClampingScrollPhysics(),
                        steps: widget.recipe.steps.asMap().entries.map((entry) {
                          final index = entry.key;
                          final step = entry.value;

                          return Step(
                            title: Text('Step ${index + 1}',
                            style: Theme.of(context).textTheme.displayMedium,),
                            content: Text(step, style: Theme.of(context).textTheme.bodyMedium),
                            isActive: index == _currentStep,
                            stepStyle: StepStyle(
                              color: greenOfBhabua,
                              connectorColor: white,
                              indexStyle: TextStyle(
                                color: cardColor,
                                fontWeight: FontWeight.bold
                              ),
                              connectorThickness: 20
                            ),
                            state: index == _currentStep ? StepState.complete : StepState.indexed,
                          );
                        }).toList(),
                        currentStep: _currentStep,
                        onStepTapped: (index) {
                          setState(() {
                            _currentStep = index;
                          });
                        },
                        onStepContinue: () {
                          if (_currentStep < widget.recipe.steps.length - 1) {
                            setState(() {
                              _currentStep++;
                            });
                          }
                        },
                        onStepCancel: () {
                          if (_currentStep > 0) {
                            setState(() {
                              _currentStep--;
                            });
                          }
                        },
                        controlsBuilder: (BuildContext context, ControlsDetails details) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: details.onStepCancel,
                                child: Text('Previous',style: TextTheme.of(context).labelSmall),
                              ),
                              ElevatedButton(
                                onPressed: details.onStepContinue,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: greenOfBhabua,
                                  minimumSize: const Size(90, 36),
                                  shape:RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)
                                  ),

                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    color: white
                                  ),
                                ),
                                child: Text('Next',
                                style: TextStyle(
                                  color: cardColor
                                )
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  SingleChildScrollView buildIngredientsSection() {
    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 5,
                        children: widget.recipe.ingredients.map((data) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: grey)
                            ),
                            child: Text(
                              data.values.first, // Display the value
                              style: TextStyle(fontSize: 12, color: greenOfBhabua),
                            ),
                          );
                        }).toList(),
                      ),
                    );
  }

  Container buildNurtitionInfoContainer() {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildNutritionCard(
            buildNutritionValueText(widget.recipe.nutrition.calories),
            buildNutritionTitleText('kcal'),
          ),
          buildNutritionCard(
            buildNutritionValueText(widget.recipe.servingSize),
            buildNutritionTitleText('serve'),
          ),
          buildNutritionCard(
            buildNutritionValueText(widget.recipe.nutrition.fat),
            buildNutritionTitleText('fat'),
          ),
          buildNutritionCard(
            buildNutritionValueText(widget.recipe.time),
            buildNutritionTitleText('min'),
          ),
        ],
      ),
    );
  }

  Flexible buildImage() {
    return Flexible(
      child: Hero(
        tag: widget.recipe.id,
        child: CachedNetworkImage(
          imageUrl: widget.recipe.imageUrl,
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Padding buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios_new_rounded, color: white),
          ),
          Text(
            widget.recipe.name,
            style: TextStyle(fontSize: 18, color: white),
          ),
          InkWell(
            child: Icon(Icons.favorite_outline_rounded, color: white),
          ),
        ],
      ),
    );
  }

  Column buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        Text(title,style: TextStyle(fontSize: 14, color: white),),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Column buildNutritionCard(Widget title, Widget value) {
    return Column(
      spacing: 5,
      children: [
        title,
        value,
      ],
    );
  }

  Text buildNutritionTitleText(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 10, color: grey),
    );
  }

  Text buildNutritionValueText(String value) {
    return Text(
      value,
      style: TextStyle(color: lightGoldenRod, fontSize: 12),
    );
  }
}
