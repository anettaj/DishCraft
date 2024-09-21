import 'package:dishcraft/Controller/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Home extends StatelessWidget {
  Home({super.key});

  final HomeController homeController= Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    double W = MediaQuery.of(context).size.width;
    double H = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: W*0.8,
                margin: EdgeInsets.only(left: 10),
                child: Text("Want do you want to cook today ?",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold
                ),
                )
            ),

            Obx(() {
              if (homeController.Recipes.isEmpty) {
                return CircularProgressIndicator();
              }

              return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: homeController.Recipes.map((Data){
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: W*0.4,
                                height: H*0.2,
                                decoration: BoxDecoration(
                          
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(image: NetworkImage("${Data.imageURL}"),
                                  fit: BoxFit.fill
                                  )
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                  child: Text("${Data.name}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),
                              )
                              )
                            ],
                          ),
                        );
                      }).toList()
                  )
              );
            }
            )

          ],
        ),
      ),
    );
  }
}
