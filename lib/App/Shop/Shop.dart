import 'package:flutter/material.dart';
import '../../Theme/Scaffold.dart';
// اگر می‌خواهید از line_icons استفاده کنید، باید این را اضافه کنید.

class Shop extends StatelessWidget {
  const Shop({super.key});

  @override
  Widget build(BuildContext context) {
    return BodyScaffold(
      body: ListView(
        padding: EdgeInsets.only(top: 20),
        children: <Widget>[
          // Cart Item 1
          _buildCartItem(
            imageUrl: 'assets/images/products/10.png',
            title: 'bluebell hand block tiered dress',
            price: 80.0,
            originalPrice: 95.0,
            rating: 2000,
            isInCart: true,
          ),
          // Cart Item 2
          _buildCartItem(
            imageUrl: 'assets/images/products/11.png',
            title: 'bluebell hand block tiered dress',
            price: 80.0,
            originalPrice: 95.0,
            rating: 2000,
            isInCart: true,
          ),
          // Cart Item 3
          _buildCartItem(
            imageUrl: 'assets/images/products/12.png',
            title: 'bluebell hand block tiered dress',
            price: 80.0,
            originalPrice: 95.0,
            rating: 2000,
            isInCart: true,
          ),
          // Cart Item 4
          _buildCartItem(
            imageUrl: 'assets/images/products/9.png',
            title: 'bluebell hand block tiered dress',
            price: 80.0,
            originalPrice: 95.0,
            rating: 2000,
            isInCart: true,
          ),
          // Total Price
          _buildTotalPrice(),
        ],
      ),
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
                    Icons.favorite_border, // استفاده از آیکن جستجو از آیکن‌های پیش‌فرض Flutter
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
