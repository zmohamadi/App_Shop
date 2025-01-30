
import 'package:flutter/material.dart';
import '../Helpers/Data.dart';
import '../../env.dart';

class Item {
  final String imagePath;
  final String title;

  Item({required this.imagePath, required this.title});
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      imagePath: '${env.mediaPath}/category/${json['image'] ?? 'default.jpg'}',
      title: json['title_fa'] ?? 'نامشخص',
    );
  }
}

class CategoryMain extends StatefulWidget {

  const CategoryMain({super.key});
  @override
  CategoryMainState createState()=> CategoryMainState();


}
class CategoryMainState extends State<CategoryMain>{
  List<Item> categories = [];
  bool isLoading = true;

  @override
  void initState(){
    super.initState();
    getCategoris();
  }
  Future<void>getCategoris()async{
    try {
      var res = Data.get('cat');
      categories = (res as List).map((item)=>Item.fromJson(item)).toList();
    } catch (e) {
      
    }
  }
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
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final product = categories[index];
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
