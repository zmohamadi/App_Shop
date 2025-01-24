import 'package:flutter/material.dart';
import '../Controllers/ThemeController.dart';
import 'package:get/get.dart';

class BaseDrawer extends StatelessWidget {
  const BaseDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>(); // دسترسی به کنترلر

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author Box
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
          // Navigation List
          Expanded(
            child: Obx(() {
              // تعیین رنگ‌ها بر اساس حالت تم
              Color iconColor = themeController.isDarkMode.value ? Colors.white : Colors.grey;
              Color textColor = themeController.isDarkMode.value ? Colors.white : Colors.black;

              return ListView(
                children: [
                  _buildDrawerItem(
                    context,
                    icon: Icons.home,
                    title: "Home",
                    onTap: () => _navigateTo(context, "/home"),
                    iconColor: iconColor,
                    textColor: textColor,
                    isSelected: true,
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.shopping_bag,
                    title: "Products",
                    onTap: () => _navigateTo(context, "/products"),
                    iconColor: iconColor,
                    textColor: textColor,
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.favorite,
                    title: "Wishlist",
                    onTap: () => _navigateTo(context, "/wishlist"),
                    iconColor: iconColor,
                    textColor: textColor,
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.receipt,
                    title: "Orders",
                    onTap: () => _navigateTo(context, "/orders"),
                    iconColor: iconColor,
                    textColor: textColor,
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.shopping_cart,
                    title: "My Cart",
                    onTap: () => _navigateTo(context, "/cart"),
                    iconColor: iconColor,
                    textColor: textColor,
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.person,
                    title: "Profile",
                    onTap: () => _navigateTo(context, "/profile"),
                    iconColor: iconColor,
                    textColor: textColor,
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.logout,
                    title: "Logout",
                    onTap: () => _logout(context),
                    iconColor: iconColor,
                    textColor: textColor,
                  ),
                ],
              );
            }),
          ),
          // Sidebar Bottom
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
                            themeController.toggleTheme(value); // تغییر تم
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

  // Drawer item builder
  Widget _buildDrawerItem(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap,
      required Color iconColor,
      required Color textColor,
      bool isSelected = false}) {
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.blue : iconColor),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.blue : textColor,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: onTap,
      selected: isSelected,
    );
  }

  // Navigation helper function
  void _navigateTo(BuildContext context, String route) {
    Navigator.of(context).pushNamed(route);
  }

  // Logout action
  void _logout(BuildContext context) {
    Navigator.of(context).pushReplacementNamed("/login");
  }
}
