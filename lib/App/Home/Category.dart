import 'package:flutter/material.dart';
import '../../env.dart';
import '../Helpers/Data.dart';

// کلاس مدل برای هر دسته بندی
class Item {
  final String imagePath; // مسیر تصویر دسته بندی
  final String title; // عنوان دسته بندی

  // سازنده برای ایجاد شیء از نوع Item
  Item({required this.imagePath, required this.title});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      imagePath: '${env.mediaPath}/category/${json['image'] ?? 'default.jpg'}',
      title: json['title_fa'] ?? 'نامشخص',
    );
  }
}

// ویجت دسته‌بندی دسته بندیها
class Category extends StatefulWidget {
  
  const Category({super.key});
  @override
  CategoryState createState()=>CategoryState();

}
class CategoryState  extends State<Category>{

  // لیست دسته بندیها
  List<Item> categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }
  Future<void>fetchCategories() async{
    setState(() {
      isLoading = true;
    });
    try {

      var result = await Data.get('categories');
      categories = (result as List).map((item) => Item.fromJson(item)).toList();
    } catch (e) {
      print(e);
    }finally{
      setState(() {
      isLoading = false;
    });
    }
  }



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
          // اسکرول افقی برای نمایش دسته بندیها
          SizedBox(
            height: 120, // ارتفاع اسکرول
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // اسکرول افقی
              itemCount: categories.length, // تعداد آیتم‌ها
              itemBuilder: (context, index) {
                final product = categories[index]; // دریافت دسته بندی بر اساس ایندکس
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0), // فاصله بین هر دسته بندی
                  child: Column(
                    children: [
                      // تصویر دسته بندی
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
                      // عنوان دسته بندی
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
                          product.title, // عنوان دسته بندی
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