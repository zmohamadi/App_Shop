import 'package:flutter/material.dart';
import '../menus.dart';
class FooterBottomBar extends StatelessWidget {
  const FooterBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: homeMenus,
    );
  }
}
