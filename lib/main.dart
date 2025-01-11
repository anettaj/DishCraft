import 'package:dishcraft/Utils/app_theme.dart';
import 'package:dishcraft/Views/home_page.dart';
import 'package:dishcraft/Views/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Utils/colors.dart';

void main() {
  runApp(const DishCraft());
}

class DishCraft extends StatelessWidget {
  const DishCraft({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      title: 'DishCraft',
      home: const SplashPage()
    );
  }
}

