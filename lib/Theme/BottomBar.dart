import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'menus.dart';

class FooterBottomBar extends StatelessWidget {
  const FooterBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showUnselectedLabels: false,
      showSelectedLabels: false,
      items: bottom.map((item) {
        return BottomNavigationBarItem(
          icon: item['icon'], // خواندن مستقیم آیکون از لیست منو
          label: item['title'],
        );
      }).toList(),
      onTap: (index) {
        Get.toNamed(bottom[index]['url']); // مسیریابی داینامیک
      },
    );
  }
}
