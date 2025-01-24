import 'package:flutter/material.dart';
import '../Theme/Scaffold.dart';
import './Home/Sliders.dart';
import './Home/LastProducts.dart';
import './Home/Category.dart';
import './Home/CategoryMain.dart';
import './Home/Brand.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BodyScaffold(
      body: SingleChildScrollView( // برای اسکرول کردن محتوا در صورت طولانی شدن
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // نمایش اسلایدر
            Sliders(),
            // const SizedBox(height: 16), // فاصله بین اسلایدر و محصولات
            // نمایش محصولات
            Category(),
            CategoryMain(),
            const SizedBox(height: 16),
            BrandSlider(),
            LastProducts(),
            
          ],
        ),
      ),
    );
  }
}
