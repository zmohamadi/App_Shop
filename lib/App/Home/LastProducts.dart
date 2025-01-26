import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../env.dart';

class ProductItem {
  final String imagePath;
  final String title;
  final String price;

  ProductItem({
    required this.imagePath,
    required this.title,
    required this.price,
  });

  // متدی برای ساخت محصول از JSON
  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      imagePath: Env.baseUrl + json['image'], // استفاده از Env.baseUrl
      title: json['name'],
      price: json['price'],
    );
  }
}

class LastProducts extends StatefulWidget {
  const LastProducts({super.key});

  @override
  _LastProductsState createState() => _LastProductsState();
}

class _LastProductsState extends State<LastProducts> {
  // لیست محصولات
  List<ProductItem> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  // تابع برای دریافت داده از API
  Future<void> fetchProducts() async {
    debugPrint('${Env.baseUrl}${Env.language}/lastProduct');
    try {
      final response = await http.get(
        Uri.parse('${Env.baseUrl}${Env.language}/lastProduct'),
      ); // استفاده از Env.baseUrl و Env.language
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          products = data.map((item) => ProductItem.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        // مدیریت خطا در صورت عدم موفقیت درخواست
        throw Exception('Failed to load products');
      }
    } catch (error) {
      print('Error fetching products: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'آخرین محصولات',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        isLoading
            ? Center(child: CircularProgressIndicator())
            : SizedBox(
                height: 230,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        // هدایت به صفحه View با اطلاعات محصول
                        Get.toNamed(
                          '/product',
                          arguments: {
                            'imagePath': product.imagePath,
                            'title': product.title,
                            'price': product.price,
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                child: Image.network(
                                  product.imagePath,
                                  width: double.infinity,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        product.price,
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
