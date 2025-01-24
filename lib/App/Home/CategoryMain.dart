import 'package:flutter/material.dart';

class ProductItem {
  final String imagePath;
  final String title;

  ProductItem({required this.imagePath, required this.title});
}

class CategoryMain extends StatelessWidget {
  final List<ProductItem> products = [
    ProductItem(
      imagePath: 'assets/images/category/11.png',
      title: 't-Shirt',
    ),
    ProductItem(
      imagePath: 'assets/images/category/22.png',
      title: 'Shirt',
    ),
    ProductItem(
      imagePath: 'assets/images/category/33.png',
      title: 'Jeans',
    ),
    ProductItem(
      imagePath: 'assets/images/category/pic2.jpg',
      title: 'Shorts',
    ),
    ProductItem(
      imagePath: 'assets/images/category/pic6.jpg',
      title: 'Shirt',
    ),
  ];

  // حذف const از سازنده
  CategoryMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // عنوان
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Featured Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        // اسکرول افقی محصولات
        SizedBox(
          height: 120, // ارتفاع بخش اسکرول
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    // تصویر محصول
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(product.imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // عنوان محصول
                    SizedBox(height: 8),
                    Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(20), // حالت بیضی
                        ),
                        child: Text(
                          product.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
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
    );
  }
}
