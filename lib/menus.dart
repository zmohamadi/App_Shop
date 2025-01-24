import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:get/get.dart';

dynamic homeMenus = [
  BottomNavigationBarItem(
    icon: IconButton(
      onPressed: () { Get.toNamed('/home'); },
      icon: LineIcon.home(size: 28.0, color: Colors.black),
    ),
    label: "خانه",
  ),
  
  BottomNavigationBarItem(
    icon: IconButton(
      onPressed: () { Get.toNamed('/shop'); },
      icon: LineIcon.shoppingCart(size: 28.0, color: Colors.black),
    ),
    label: "فروشگاه",
  ),
 
  // BottomNavigationBarItem(
  //   icon: IconButton(
  //     onPressed: () { Get.toNamed('/note'); },
  //     icon: LineIcon.book(size: 28.0, color: Colors.black), // آیکن جدید برای یادداشت‌ها
  //   ),
  //   label: "یادداشت‌ها",
  // ),
  BottomNavigationBarItem(
    icon: IconButton(
      onPressed: () { Get.toNamed('/wishlist'); },
      icon: LineIcon.heart(size: 28.0, color: Colors.black),
    ),
    label: "علاقه‌مندی‌ها",
  ),
   BottomNavigationBarItem(
    icon: IconButton(
      onPressed: () { Get.toNamed('/user'); },
      icon: LineIcon.user(size: 28.0, color: Colors.black),
    ),
    label: "پروفایل",
  ),
];
