import 'dart:async'; // وارد کردن بسته برای استفاده از تایمر
import 'package:flutter/material.dart'; // وارد کردن بسته برای استفاده از ویجت‌های فلاتر

// تعریف ویجت اصلی اسلایدر برندها
class BrandSlider extends StatefulWidget {
  const BrandSlider({super.key});

  @override
  _BrandSliderState createState() => _BrandSliderState(); // ایجاد وضعیت برای ویجت
}

class _BrandSliderState extends State<BrandSlider> {
  // لیست برندها که باید نمایش داده شوند
  final List<String> brands = [
    "Brand 1",
    "Brand 2",
    "Brand 3 with a longer title",
    "Brand 4",
    "Brand 5",
  ];

  late ScrollController _scrollController; // کنترل اسکرول برای حرکت لیست
  late Timer _timer; // تایمر برای حرکت اتوماتیک اسکرول

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(); // ایجاد کنترلر اسکرول
    _startAutoScroll(); // شروع حرکت اتوماتیک اسکرول
  }

  // تابع برای شروع حرکت اتوماتیک اسکرول
  void _startAutoScroll() {
    const duration = Duration(milliseconds: 50); // تنظیم سرعت حرکت
    _timer = Timer.periodic(duration, (timer) {
      if (_scrollController.hasClients) { // بررسی اینکه آیا کنترلر به ویجت متصل است
        final maxScroll = _scrollController.position.maxScrollExtent; // بیشترین مقدار اسکرول
        final currentScroll = _scrollController.offset; // مقدار فعلی اسکرول
        if (currentScroll >= maxScroll) {
          _scrollController.jumpTo(0); // اگر به انتها رسید، به ابتدا برگرد
        } else {
          // اگر به انتها نرسیده، اسکرول به جلو حرکت کند
          _scrollController.animateTo(
            currentScroll + 2, // حرکت به جلو
            duration: const Duration(milliseconds: 50), // مدت زمان انیمیشن
            curve: Curves.linear, // نوع انیمیشن خطی
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // متوقف کردن تایمر هنگام از بین رفتن ویجت
    _scrollController.dispose(); // آزاد کردن کنترلر اسکرول
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0, // ارتفاع اسلایدر
      decoration: BoxDecoration(
        color: Colors.white, // رنگ پس زمینه سفید
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 2.0), // بردر بالا
          bottom: BorderSide(color: Colors.grey.shade300, width: 2.0), // بردر پایین
        ),
      ),
      child: ListView.separated(
        controller: _scrollController, // استفاده از کنترلر برای لیست
        scrollDirection: Axis.horizontal, // اسکرول افقی
        itemCount: brands.length, // تعداد برندها
        separatorBuilder: (context, index) {
          return const Icon(
            Icons.star_border, // آیکن ستاره به عنوان جداکننده بین برندها
            size: 30.0,
            color: Colors.grey,
          );
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0), // فاصله بین برندها
            child: Brand(title: brands[index]), // ارسال عنوان برند به ویجت Brand
          );
        },
      ),
    );
  }
}

// تعریف ویجت نمایشی برند
class Brand extends StatelessWidget {
  final String title; // عنوان برند

  const Brand({
    super.key,
    required this.title, // عنوان برند به عنوان ورودی دریافت می‌شود
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0), // فضای داخلی برند
      alignment: Alignment.center, // مرکز قرار دادن متن برند
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), // گوشه‌های گرد برای برند
      ),
      child: Text(
        title, // نمایش عنوان برند
        textAlign: TextAlign.center, // تنظیم متن به صورت مرکزی
        style: const TextStyle(
          fontSize: 14.0, // اندازه فونت برند
          fontWeight: FontWeight.bold, // فونت پررنگ
        ),
      ),
    );
  }
}

// تابع main برای اجرای برنامه
void main() {
  runApp(const MyApp()); // اجرای ویجت MyApp
}

// ویجت اصلی برنامه
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Brand Slider Example"), // عنوان اپلیکیشن
        ),
        body: Center(
          child: BrandSlider(), // نمایش ویجت BrandSlider در وسط صفحه
        ),
      ),
    );
  }
}
