import 'package:flutter/material.dart';
import '../../env.dart';
import '../Helpers/Data.dart';

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

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      imagePath: '${env.mediaPath}/product/${json['image'] ?? 'default.jpg'}',
      title: json['name'] ?? 'نامشخص',
      price: json['price']?.toString() ?? '0',
    );
  }
}

// ویجت اصلی
class LastProducts extends StatefulWidget {
  const LastProducts({super.key});

  @override
  LastProductsState createState() => LastProductsState();
}

class LastProductsState extends State<LastProducts> {
  List<ProductItem> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    setState(() => isLoading = true);
    try {
      final response = await Data.get('lastProduct');
      products = (response as List).map((item) => ProductItem.fromJson(item)).toList();
    } catch (e) {
      debugPrint('خطا: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'آخرین محصولات'),
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : ProductList(products: products),
      ],
    );
  }
}

// ویجت عنوان بخش
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

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

  const ProductList({Key? key, required this.products}) : super(key: key);

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

  const ProductCard({Key? key, required this.product}) : super(key: key);

  void _onActionPressed(String action) {
    print('$action ${product.title}');
  }

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
            ProductImage(
              imagePath: product.imagePath,
              onLikePressed: () => _onActionPressed('Liked'),
              onBuyPressed: () => _onActionPressed('Added to cart'),
            ),
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
  final VoidCallback onLikePressed;
  final VoidCallback onBuyPressed;

  const ProductImage({
    Key? key,
    required this.imagePath,
    required this.onLikePressed,
    required this.onBuyPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          child: Image.network(
            imagePath,
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(top: 5, right: 5, child: ActionButton(icon: Icons.favorite_border, onPressed: onLikePressed)),
        Positioned(top: 5, left: 5, child: ActionButton(icon: Icons.shopping_cart_outlined, onPressed: onBuyPressed)),
      ],
    );
  }
}

// جزئیات محصول
class ProductDetails extends StatelessWidget {
  final ProductItem product;

  const ProductDetails({Key? key, required this.product}) : super(key: key);

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

// دکمه اکشن
class ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const ActionButton({Key? key, required this.icon, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(color: Colors.black26, shape: BoxShape.circle),
        child: Icon(icon, size: 20, color: Colors.white),
      ),
    );
  }
}
