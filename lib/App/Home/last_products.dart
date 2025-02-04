import 'package:flutter/material.dart';
import '../../env.dart';

// مدل محصول
class ProductItem {
  final String imagePath;
  final String title;
  final String price;

  ProductItem({
    required this.imagePath,
    required this.title,
    required this.price,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) => ProductItem(
        imagePath: '${env.mediaPath}/product/${json['image'] ?? 'default.jpg'}',
        title: json['name'] ?? 'نامشخص',
        price: (json['price'] ?? '0').toString(),
      );
}

// ویجت اصلی
class LastProducts extends StatefulWidget {
  final List<dynamic> data; // تعریف پارامتر برای دریافت داده
  final Map<String, String> trans;  // تعریف trans به عنوان Map

  const LastProducts({required this.data, required this.trans, super.key});  // اصلاح constructor

  @override
  LastProductsState createState() => LastProductsState();
}

class LastProductsState extends State<LastProducts> {
  late List<ProductItem> products;

  @override
  void initState() {
    super.initState();
    products = widget.data.map((item) => ProductItem.fromJson(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'آخرین محصولات'),
        ProductList(products: products),
      ],
    );
  }
}

// ویجت عنوان بخش
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// لیست محصولات
class ProductList extends StatelessWidget {
  final List<ProductItem> products;

  const ProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) => ProductCard(product: products[index]),
      ),
    );
  }
}

// کارت محصول
class ProductCard extends StatelessWidget {
  final ProductItem product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(0, 3))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImage(imagePath: product.imagePath),
            ProductDetails(product: product),
          ],
        ),
      ),
    );
  }
}

// تصویر محصول
class ProductImage extends StatelessWidget {
  final String imagePath;

  const ProductImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      child: Image.network(
        imagePath,
        width: double.infinity,
        height: 150,
        fit: BoxFit.cover,
      ),
    );
  }
}

// جزئیات محصول
class ProductDetails extends StatelessWidget {
  final ProductItem product;

  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${product.price} تومان',
            style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
