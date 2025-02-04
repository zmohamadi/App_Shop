import 'package:flutter/material.dart';
import '../../Theme/Scaffold.dart';
import '../../env.dart';
import '../App/helpers/data.dart';

class ShopItems{
  final String imagePath;
  final String title;
  final String price;
  final String originalPrice;
  final bool isInCart;

  ShopItems({
    required this.imagePath,
    required this.title,
    required this.price,
    required this.originalPrice,
    required this.isInCart,
  });

  factory ShopItems.fromJson(Map<String, dynamic> json) => ShopItems(
        imagePath: '${env.mediaPath}/product/${json['image'] ?? 'default.jpg'}',
        title: json['name'] ?? 'نامشخص',
        price: (json['price'] ?? '0').toString(),
        originalPrice: (json['price'] ?? '0').toString(),
        isInCart: false,
      );

}
class Shop extends StatefulWidget {
  
  const Shop({super.key});
  @override
  ShopState createState()=>ShopState();
}
class ShopState extends State<Shop>{
    late Map<String, String> trans;

List<ShopItems> data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    setState(() => isLoading = true);
    try {
      final response = await Data.get('product-list');
      data = (response as List).map((item) => ShopItems.fromJson(item)).toList();
    } catch (e) {
      debugPrint('خطا: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BodyScaffold(
      body:Column(
        children: [
          Expanded(child: ListView.builder(
          padding: EdgeInsets.only(top: 20),
          itemCount: data.length,
          itemBuilder: (context, index) {
          final product = data[index];
          // Cart Item 4
          return _buildCartItem(
            imageUrl: product.imagePath,
            title: product.title,
            price: double.parse(product.price),
            originalPrice: double.parse(product.originalPrice),
            rating: 1000, // مقدار تستی، بعداً می‌توان از API گرفت
            isInCart: product.isInCart,
           );
        },
      ),)
        ,_buildTotalPrice()],
      
      )
    );
  }

  // Cart Item Widget
  Widget _buildCartItem({
    required String imageUrl,
    required String title,
    required double price,
    required double originalPrice,
    required int rating,
    required bool isInCart,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        children: <Widget>[
          // Product Image with rounded corners and icon overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
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
                    color: Colors.black.withOpacity(0.3), // بک‌گراند نیمه شفاف
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
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Row(
                  children: <Widget>[
                    Text('\$$price', style: TextStyle(fontSize: 14, color: Colors.green)),
                    SizedBox(width: 5),
                    Text('\$$originalPrice', style: TextStyle(fontSize: 12, decoration: TextDecoration.lineThrough)),
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
                // Quantity and Remove Option
                Row(
                  children: <Widget>[
                    // Quantity Selector with black circular background and white icon
                    Container(
                       width: 30, // تنظیم عرض Container برای کوچک‌تر کردن
                        height: 30, // تنظیم ارتفاع Container برای کوچک‌تر کردن
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.remove, color: Colors.white), // آیکن کم کردن
                        iconSize: 16, // اندازه آیکن را کوچک‌تر کرده‌ایم
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 5),
                    Text('1', style: TextStyle(fontSize: 14)),
                    SizedBox(width: 5),
                    Container(
                       width: 30, // تنظیم عرض Container برای کوچک‌تر کردن
                    height: 30, // تنظیم ارتفاع Container برای کوچک‌تر کردن
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add, color: Colors.white), // آیکن اضافه کردن
                        iconSize: 16, // اندازه آیکن را کوچک‌تر کرده‌ایم
                        onPressed: () {},
                      ),
                    ),
                    Spacer(),
                    // Remove Button with Delete Icon
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red), // استفاده از آیکن حذف از آیکن‌های پیش‌فرض Flutter
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

  // Total Price Widget
  Widget _buildTotalPrice() {
    return Container(
      padding: EdgeInsets.all(15),
      color: Colors.blue.shade50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Subtotal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text('\$3,599', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
