import 'package:flutter/material.dart';
import '../Theme/Scaffold.dart';
import './home/Sliders.dart';
import './home/last_products.dart';
import './home/Category.dart';
import './home/category_main.dart';
import './home/Brand.dart';
import './Helpers/Data.dart';
import './Helpers/localizations.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {  
  Map<String, dynamic> data = {};  // اصلاح نحوه تعریف
  late Map<String, String> _trans = {};
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
      data = await Data.get('home'); // اصلاح نحوه بارگذاری داده
      _trans = await getLang();
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
                  if (data.containsKey('sliders'))  Sliders(data: data['sliders'], trans: _trans),  // اصلاح نحوه فراخوانی
                  if (data.containsKey('categories')) Category(data : data['categories'] , trans: _trans),
                  if (data.containsKey('categories')) CategoryMain(data : data['categories'] , trans: _trans),
                  const SizedBox(height: 16),
                  if (data.containsKey('brands')) BrandSlider(),
                  if (data.containsKey('lastProducts')) LastProducts(data : data['lastProducts'] , trans: _trans),
                  const SizedBox(height: 16),

                ],
              ),
            ),
    );
  }
}
