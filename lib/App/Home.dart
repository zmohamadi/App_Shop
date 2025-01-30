import 'package:flutter/material.dart';
import '../Theme/Scaffold.dart';
import './Home/Sliders.dart';
import './Home/LastProducts.dart';
import './Home/Category.dart';
import './Home/CategoryMain.dart';
import './Home/Brand.dart';
import './Helpers/Data.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  Map<String, dynamic> data = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    try {
      data = await Data.get('home');
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BodyScaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // نمایش لودینگ در هنگام بارگیری داده‌ها
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (data.containsKey('sliders')) Sliders(data = data['sliders']),
                  if (data.containsKey('categories')) Category(data = data['categories']),
                  if (data.containsKey('categories')) CategoryMain(data = data['categories']),
                  const SizedBox(height: 16),
                  if (data.containsKey('brands')) BrandSlider(),
                  if (data.containsKey('lastProducts')) LastProducts(data = data['lastProducts']),
                ],
              ),
            ),
    );
  }
}
