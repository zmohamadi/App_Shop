import 'package:flutter/material.dart';

// کلاس مدل برای هر اسلایدر
class SliderItem {
  final String imagePath; // مسیر تصویر
  final String title;
  final String description;

  SliderItem({required this.imagePath, required this.title, required this.description});
}

class Sliders extends StatelessWidget {
  // داده‌های اسلایدر با مسیر محلی
  final List<SliderItem> sliders = [
    SliderItem(
      imagePath: 'assets/images/slider/banner-media4.png',
      title: 'Slider 1',
      description: 'This is the description for slider 1.',
    ),
    SliderItem(
      imagePath: 'assets/images/slider/banner-media2.png',
      title: 'Slider 2',
      description: 'This is the description for slider 2.',
    ),
    SliderItem(
      imagePath: 'assets/images/slider/banner-media3.png',
      title: 'Slider 3',
      description: 'This is the description for slider 3.',
    ),
  ];

  // حذف const از سازنده
  Sliders({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // اسکرول افقی
        itemCount: sliders.length, // تعداد آیتم‌ها
        itemBuilder: (context, index) {
          final slider = sliders[index];
          return Padding(
            padding: const EdgeInsets.all(8.0), // فاصله اطراف هر اسلایدر
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // گوشه‌های گرد
              child: Container(
                width: 300, // عرض اسلایدر
                color: Colors.grey, // رنگ پس‌زمینه
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // تراز از چپ
                  children: [
                    // تصویر اسلایدر
                    Image.asset(
                      slider.imagePath,
                      width: double.infinity, // عرض تصویر کامل
                      height: 113, // ارتفاع تصویر
                      fit: BoxFit.cover, // تنظیم نمایش تصویر
                    ),
                    // این قسمت‌ها کامنت شده‌اند، می‌توانید آن‌ها را فعال کنید
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     slider.title,
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 18,
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(slider.description),
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
