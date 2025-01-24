import 'package:flutter/material.dart';
import '../../Theme/Scaffold.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return BodyScaffold(
      body: ListView(
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
        _buildImageSwiper(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Men Black Grey Allover Printed Round Neck T-Shirt",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  SizedBox(width: 5),
                  Text(
                    "4.5 (470)",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Price:",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "\$270",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const Text(
                        "\$310",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "Quantity:",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {},
                          ),
                          const Text("2", style: TextStyle(fontSize: 16)),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "Items Size:",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: ["S", "M", "L", "XL", "2XL"]
                    .map((size) => ChoiceChip(
                          label: Text(size),
                          selected: size == "M",
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),
              const Text(
                "Items Color:",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Colors.brown,
                  Colors.blue,
                  Colors.orange,
                  Colors.grey,
                  Colors.purple,
                  Colors.green
                ]
                    .map((color) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: CircleAvatar(
                            backgroundColor: color,
                            radius: 15,
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),
              const Text(
                "Description:",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              const Text(
                "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humor.",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImageSwiper() {
    final imagePaths = [
      'assets/images/products/6.png',
      'assets/images/products/7.png',
      'assets/images/products/8.png',
    ];

    return SizedBox(
      height: 300,
      child: PageView.builder(
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Image.asset(
                imagePaths[index],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () {},
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
