import 'package:flutter/material.dart';

// کلاس مدل برای هر محصول
class ProductItem {
  final String imagePath; // مسیر تصویر محصول
  final String title; // عنوان محصول

  // سازنده برای ایجاد شیء از نوع ProductItem
  ProductItem({required this.imagePath, required this.title});
}

// ویجت دسته‌بندی محصولات
class Category extends StatelessWidget {
  // لیست محصولات
  final List<ProductItem> products = [
    ProductItem(
      imagePath: 'assets/images/category/1.png',
      title: 't-Shirt',
    ),
    ProductItem(
      imagePath: 'assets/images/category/2.png',
      title: 'Shirt',
    ),
    ProductItem(
      imagePath: 'assets/images/category/3.png',
      title: 'Jeans',
    ),
    ProductItem(
      imagePath: 'assets/images/category/4.png',
      title: 'Shorts',
    ),
  ];

  // سازنده بدون const
  Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFEEB9D), // رنگ پس‌زمینه برای Container
      padding: const EdgeInsets.symmetric(vertical: 16.0), // حاشیه داخلی از بالا و پایین
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // تراز کردن از سمت چپ
        children: [
          // عنوان دسته‌بندی
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // حاشیه داخلی از چپ و راست
            child: Text(
              'Featured Categories', // متن عنوان
              style: TextStyle(
                fontSize: 20, // اندازه فونت
                fontWeight: FontWeight.w500, // وزن فونت
              ),
            ),
          ),
          const SizedBox(height: 16), // فضای خالی بین عنوان و اسکرول
          // اسکرول افقی برای نمایش محصولات
          SizedBox(
            height: 120, // ارتفاع اسکرول
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // اسکرول افقی
              itemCount: products.length, // تعداد آیتم‌ها
              itemBuilder: (context, index) {
                final product = products[index]; // دریافت محصول بر اساس ایندکس
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0), // فاصله بین هر محصول
                  child: Column(
                    children: [
                      // تصویر محصول
                      Container(
                        height: 80, // ارتفاع تصویر
                        width: 80, // عرض تصویر
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(product.imagePath), // استفاده از مسیر تصویر
                            fit: BoxFit.cover, // تنظیم نمایش تصویر به طور کامل
                          ),
                        ),
                      ),
                      const SizedBox(height: 8), // فاصله بین تصویر و عنوان
                      // عنوان محصول
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ), // حاشیه داخلی
                        decoration: BoxDecoration(
                          color: Colors.white, // پس‌زمینه سفید
                          border: Border.all(color: Colors.black), // حاشیه سیاه
                          borderRadius: BorderRadius.circular(20), // گوشه‌های گرد
                        ),
                        child: Text(
                          product.title, // عنوان محصول
                          style: TextStyle(
                            fontSize: 14, // اندازه فونت
                            fontWeight: FontWeight.w400, // وزن فونت
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
