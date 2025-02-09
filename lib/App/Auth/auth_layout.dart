import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthLayout extends StatelessWidget {
  final Widget child; // محتوای متغیر صفحه (مثلاً فرم ورود یا ثبت‌نام)
  
  const AuthLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // تصویر پس‌زمینه
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/2.jpg',
              height: 150, // ارتفاع تصویر
              fit: BoxFit.cover, // پر کردن فضای موجود
            ),
          ),

          // محتوای صفحه
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 15), // فاصله برای دکمه بازگشت
                
                // دکمه بازگشت
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Get.back(),
                    ),
                  ),
                ),

                const SizedBox(height: 100), // فاصله بین تصویر و فرم

                // محتوای متغیر صفحه (فرم ورود، ثبت‌نام و ...)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: child, 
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
