import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

final List<Map<String, dynamic>> bottom = [
  {"title": "خانه", 'url': '/home', 'icon': LineIcon.home(size: 28.0, color: Colors.black) },
  {"title": "فروشگاه", 'url': '/shop', 'icon': LineIcon.shoppingCart(size: 28.0, color: Colors.black) },
  {"title": "علاقه‌مندی", 'url': '/wishlist', 'icon': LineIcon.heart(size: 28.0, color: Colors.black) },
  {"title": "کاربر", 'url': '/user', 'icon': LineIcon.user(size: 28.0, color: Colors.black) },
];

final List<Map<String, dynamic>> drawer = [
  {'title': 'Home', 'url': '/home', 'icon': Icons.home },
  {'title': 'Products', 'url': '/products', 'icon': Icons.shopping_bag },
  {'title': 'Wishlist', 'url': '/wishlist', 'icon': Icons.favorite },
  {'title': 'Orders', 'url': '/orders', 'icon': Icons.receipt },
  {'title': 'My Cart', 'url': '/cart', 'icon': Icons.shopping_cart },
  {'title': 'Profile', 'url': '/profile', 'icon': Icons.person },
  {'title': 'Logout', 'url': '/login', 'icon': Icons.logout },
];
