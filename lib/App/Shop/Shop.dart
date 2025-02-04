import 'package:flutter/material.dart';
import '../../Theme/Scaffold.dart';
import '../../env.dart';
import '../Helpers/Data.dart';
import 'package:get/get.dart';

class ShopItems {
  final String imagePath;
  final String title;
  final int id;
  final String price;
  final String originalPrice;
  final bool isInCart;

  ShopItems({
    required this.imagePath,
    required this.title,
    required this.id,
    required this.price,
    required this.originalPrice,
    required this.isInCart,
  });

  factory ShopItems.fromJson(Map<String, dynamic> json) => ShopItems(
        imagePath: '${env.mediaPath}/product/${json['image'] ?? 'default.jpg'}',
        title: json['name'] ?? 'نامشخص',
        id:json['id'],
        price: (json['price'] ?? '0').toString(),
        originalPrice: (json['price'] ?? '0').toString(),
        isInCart: false,
      );
}

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  ShopState createState() => ShopState();
}

class ShopState extends State<Shop> {
  List<ShopItems> data = [];
  bool isLoading = true;
  bool isMoreLoading = false;
  int page = 1; // صفحه فعلی برای درخواست داده‌های بیشتر
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchProducts();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose(); // پاکسازی ScrollController
    super.dispose();
  }

  Future<void> fetchProducts({bool loadMore = false}) async {
    if (loadMore) {
      setState(() => isMoreLoading = true);
    } else {
      setState(() => isLoading = true);
    }

    try {
      final response = await Data.get('product-list?page=$page');

      // بررسی کنید که response یک Map است و دارای کلید 'data' می‌باشد
      final List<dynamic> items = response['products']['data'];
      // final List<dynamic> items = (response is Map<String, dynamic> && response.containsKey('data'))
      //     ? response['data'] as List<dynamic>
      //     : [];

      final List<ShopItems> newData = items.map((item) => ShopItems.fromJson(item)).toList();

      setState(() {
        if (loadMore) {
          data.addAll(newData);
        } else {
          data = newData;
        }
        page++;
      });
    } catch (e) {
      debugPrint('خطا: $e');
    } finally {
      setState(() {
        isLoading = false;
        isMoreLoading = false;
      });
    }
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        if (!isMoreLoading) {
          fetchProducts(loadMore: true);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BodyScaffold(
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator()) // نمایش لودینگ هنگام بارگذاری اولیه
                : ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.only(top: 20),
                    itemCount: data.length + 1, // یک آیتم اضافه برای لودینگ بیشتر
                    itemBuilder: (context, index) {
                      if (index == data.length) {
                        return isMoreLoading
                            ? Padding(
                                padding: EdgeInsets.all(10),
                                child: Center(child: CircularProgressIndicator()))
                            : SizedBox(); // نمایش لودینگ هنگام بارگذاری بیشتر
                      }
                      final product = data[index];
                      return _buildCartItem(
                        imageUrl: product.imagePath,
                        title: product.title,
                        id: product.id,
                        price: double.parse(product.price),
                        originalPrice: double.parse(product.originalPrice),
                        rating: 1000,
                        isInCart: product.isInCart,
                      );
                    },
                  ),
          ),
          _buildTotalPrice()
        ],
      ),
    );
  }


Widget _buildCartItem({
  required String imageUrl,
  required String title,
  required int id,
  required double price,
  required double originalPrice,
  required int rating,
  required bool isInCart,
}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    child: Row(
      children: <Widget>[
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                imageUrl,
                width: 100,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.favorite_border,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Get.toNamed('/product/$id'); // ارسال id در مسیر
                },
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    // color: Colors.blue, // نمایش لینک به سبک لینک‌های اینترنتی
                    // decoration: TextDecoration.underline, // خط زیر عنوان
                  ),
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: <Widget>[
                  Text('\$$price', style: TextStyle(fontSize: 14, color: Colors.green)),
                  SizedBox(width: 5),
                  Text(
                    '\$$originalPrice',
                    style: TextStyle(fontSize: 12, decoration: TextDecoration.lineThrough),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: <Widget>[
                  Icon(Icons.star, size: 16, color: Colors.yellow),
                  Text('($rating Reviews)', style: TextStyle(fontSize: 12)),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.remove, color: Colors.white),
                      iconSize: 16,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 5),
                  Text('1', style: TextStyle(fontSize: 14)),
                  SizedBox(width: 5),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add, color: Colors.white),
                      iconSize: 16,
                      onPressed: () {},
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


  Widget _buildTotalPrice() {
    return Container(
      padding: EdgeInsets.all(15),
      color: Colors.blue.shade50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Subtotal',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text('\$3,599',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
