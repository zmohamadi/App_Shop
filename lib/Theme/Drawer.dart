import 'package:flutter/material.dart';
import '../Controllers/ThemeController.dart';
import 'package:get/get.dart';
import 'menus.dart'; // فایل منوها

class BaseDrawer extends StatelessWidget {
  const BaseDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // بخش اطلاعات کاربر
          UserAccountsDrawerHeader(
            accountName: const Text("Roopa"),
            accountEmail: const Text("example@gmail.com"),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/profile1.jpg"),
            ),
            decoration: BoxDecoration(
              color: Colors.blue.shade800,
            ),
          ),
          // منوهای دراور
          Expanded(
            child: Obx(() {
              Color iconColor = themeController.isDarkMode.value ? Colors.white : Colors.grey;
              Color textColor = themeController.isDarkMode.value ? Colors.white : Colors.black;

              return ListView(
                children: drawer.map((item) {
                  return _buildDrawerItem(
                    context,
                    icon: item['icon'],
                    title: item['title'],
                    onTap: () => _navigateTo(context, item['url']),
                    iconColor: iconColor,
                    textColor: textColor,
                  );
                }).toList(),
              );
            }),
          ),
          // تنظیمات و اطلاعات نسخه
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.nightlight_round, color: Colors.grey),
                    const SizedBox(width: 8),
                    const Text("Dark Mode"),
                    const Spacer(),
                    Obx(() => Switch(
                          value: themeController.isDarkMode.value,
                          onChanged: (value) {
                            themeController.toggleTheme(value);
                          },
                        )),
                  ],
                ),
                const Divider(),
                const Text(
                  "Pixio Fashion Store",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text("App Version 1.0"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // تابع ساخت آیتم‌های دراور
  Widget _buildDrawerItem(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap,
      required Color iconColor,
      required Color textColor}) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.normal,
        ),
      ),
      onTap: onTap,
    );
  }

  // تابع مسیریابی
  void _navigateTo(BuildContext context, String route) {
    Navigator.of(context).pushNamed(route);
  }
}
