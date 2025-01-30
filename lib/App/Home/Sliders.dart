import 'package:flutter/material.dart';

class SliderItem {
  final String imagePath;
  final String title;
  final String price;
  final List<String> sizes;

  SliderItem({
    required this.imagePath,
    required this.title,
    required this.price,
    required this.sizes,
  });
}

class Sliders extends StatefulWidget {
  const Sliders({super.key});

  @override
  SlidersState createState() => SlidersState();
}

class SlidersState extends State<Sliders> {
  // داده‌های اسلایدر
  final List<SliderItem> sliders = [
    SliderItem(
      imagePath: 'assets/images/slider/pic5.jpg',
      title: 'Make your fashion look more charming',
      price: '\$168',
      sizes: ['X', 'M', 'S'],
    ),
    SliderItem(
      imagePath: 'assets/images/slider/banner-media4.png',
      title: 'Explore Our Latest Collections Here',
      price: '\$265',
      sizes: ['X', 'M', 'S'],
    ),
    SliderItem(
      imagePath: 'assets/images/slider/pic6.jpg',
      title: 'Incorporate Vintage or Unique Pieces',
      price: '\$550',
      sizes: ['X', 'M', 'S'],
    ),
  ];

  // متغیر برای انتخاب سایز
  List<String> selectedSizes = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4, // ارتفاع داینامیک
      child: PageView.builder(
        itemCount: sliders.length,
        itemBuilder: (context, index) {
          final slider = sliders[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0), // فاصله از لبه‌ها
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade200,
              ),
              child: Row(
                children: [
                  // محتوای سمت چپ
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            slider.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            textDirection: TextDirection.rtl, // متن راست به چپ
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Price",
                            style: TextStyle(fontSize: 12),
                            textDirection: TextDirection.rtl,
                          ),
                          Text(
                            slider.price,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Select Size",
                            style: TextStyle(fontSize: 12),
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            children: slider.sizes.map((size) {
                              return ChoiceChip(
                                label: Text(size),
                                selected: selectedSizes.contains(size),
                                onSelected: (isSelected) {
                                  setState(() {
                                    if (isSelected) {
                                      selectedSizes.add(size);
                                    } else {
                                      selectedSizes.remove(size);
                                    }
                                  });
                                },
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text("View Details"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // محتوای سمت راست (عکس)
                  ClipRRect(
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(15),
                    ),
                    child: Image.asset(
                      slider.imagePath,
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.4,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(Icons.broken_image, size: 50, color: Colors.red),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
