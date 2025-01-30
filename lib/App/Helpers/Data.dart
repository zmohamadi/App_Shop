import 'dart:convert';
import 'package:flutter/material.dart'; // برای debugPrint
import 'package:http/http.dart' as http;
import '../../env.dart';

class Data {
  static Future<dynamic> get(String url) async {
    try {
      // ارسال درخواست GET به URL مشخص‌شده
      final response = await http.get(Uri.parse('${env.baseUrl}/${env.local}/${url}'));
      
      // بررسی وضعیت پاسخ
      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isNotEmpty) {
          return json.decode(response.body); // داده‌های موفق
        } else {
          return null; // پاسخ خالی
        }
      } else {
        throw Exception('خطا در دریافت اطلاعات: ${response.statusCode}');
      }
    } catch (e) {
      // لاگ کردن خطا برای دیباگ
      debugPrint('خطا در درخواست GET: $e');
      throw Exception('خطا: $e');
    }
  }
}
