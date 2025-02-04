import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './Theme/routes.dart';
import './Controllers/ThemeController.dart';

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    // ثبت کنترلر
    final themeController = Get.put(ThemeController());

    return Obx(() {
      return GetMaterialApp(
        initialRoute: '/home',
        textDirection: TextDirection.rtl,
        getPages: routes,
        debugShowCheckedModeBanner: false,
        theme: themeController.isDarkMode.value
            ? ThemeData.dark()
            : ThemeData.light(),
      );
    });
  }
}
