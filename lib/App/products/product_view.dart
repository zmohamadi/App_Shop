import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Theme/Scaffold.dart';
import '../../env.dart';
import '../Helpers/Data.dart';

// مدل داده‌ای محصول
class ProductViewItems {
  final String imagePath;
  final String title;
  final int id;
  final String price;
  final String originalPrice;
  final bool isInCart;

  ProductViewItems({
    required this.imagePath,
    required this.title,
    required this.id,
    required this.price,
    required this.originalPrice,
    required this.isInCart,
  });

  factory ProductViewItems.fromJson(Map<String, dynamic> json) => ProductViewItems(
        imagePath: '${env.mediaPath}/product/${json['image'] ?? 'default.jpg'}',
        title: json['name'] ?? 'نامشخص',
        id: (json['id'] ?? 0) as int, // Ensure id is never null
        price: (json['price'] ?? '0').toString(),
        originalPrice: (json['original_price'] ?? json['price'] ?? '0').toString(),
        isInCart: json['is_in_cart'] ?? false,
      );
}

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  ProductViewState createState() => ProductViewState();
}

class ProductViewState extends State<ProductView> {
  ProductViewItems? product;
  bool isLoading = true;
  final String productId = Get.parameters['id'] ?? '0';

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    setState(() => isLoading = true);
    try {
      final response = await Data.get('product-view/$productId');
      setState(() {
        product = ProductViewItems.fromJson(response['product']);
      });
    } catch (e) {
      debugPrint('خطا: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BodyScaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : product == null
              ? const Center(child: Text('محصول یافت نشد'))
              : ListView(
                  padding: const EdgeInsets.only(top: 20),
                  children: <Widget>[
                    _buildProductDetail(),
                  ],
                ),
    );
  }

  Widget _buildProductDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(product!.imagePath, height: 250, fit: BoxFit.cover),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product!.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  SizedBox(width: 5),
                  Text("4.5 (470)", style: TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("قیمت:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 4),
                      Text("${product!.price} تومان", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                      Text("${product!.originalPrice} تومان", style: const TextStyle(fontSize: 14, color: Colors.red, decoration: TextDecoration.lineThrough)),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(product!.isInCart ? "در سبد خرید" : "افزودن به سبد"),
                  )
                ],
              ),
              const SizedBox(height: 16),
              const Text("توضیحات:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              const Text(
                "این محصول دارای بهترین کیفیت ممکن است و شما می‌توانید آن را با تخفیف ویژه تهیه کنید.",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
