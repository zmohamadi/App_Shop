import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  // حالت اولیه روشن
  RxBool isDarkMode = false.obs;

  // تغییر حالت
  void toggleTheme(bool value) {
    isDarkMode.value = value;
    Get.changeTheme(value ? ThemeData.dark() : ThemeData.light());
  }
}
