import 'package:cached_network_image/cached_network_image.dart';
import 'package:dishcraft/Utils/colors.dart';
import 'package:dishcraft/Views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    String imageurl='https://res.cloudinary.com/dljwalapq/image/upload/v1736614476/recepies/Pngtree_chicken_biryani_halal_food_14674148_qsikok.png';
    // String imageurl='https://res.cloudinary.com/dljwalapq/image/upload/v1736616154/recepies/ic_popular_food_6_fbvprl.png';
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 30,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: imageurl,
                errorWidget: (context, url, error) => Icon(Icons.error,color: white,),
                fit: BoxFit.contain,
              ),
            ),
            RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Find the perfect \nrecipes ',
                      style: TextStyle(
                        color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40
                      )
                    ),
                    TextSpan(
                        text: 'everyday',
                      style: TextStyle(
                        color: greenOfBhabua,
                        fontWeight: FontWeight.bold,
                        fontSize: 40
                      )
                    )
                  ]
                )
            ),
            ElevatedButton(
                onPressed: (){
                  Get.to(()=>Home());
                },
                style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all(Size(double.infinity, 36)),
                  backgroundColor: WidgetStateProperty.all(lightGoldenRod),
                  padding: WidgetStatePropertyAll(EdgeInsets.all(20))
                ),
                child: Text('Get Started',
                  style: TextStyle(
                    color: cardColor
                  ),)
            )
          ],
        ),
      ),
      );
  }
}
