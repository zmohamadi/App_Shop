import 'dart:convert';
import 'package:flutter/material.dart'; // برای debugPrint
import 'package:http/http.dart' as http;
import '../../env.dart';

class Data {
  /// متد `GET` برای دریافت داده‌ها از سرور
  static Future<dynamic> get(String url) async {
    try {
      final response = await http.get(Uri.parse('${env.apiPath}$url'));

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
      debugPrint('خطا در درخواست GET: $e');
      throw Exception('خطا: $e');
    }
  }

  /// متد `POST` برای ارسال داده‌ها به سرور
  static Future<dynamic> post(String url, Map<String, dynamic> data, {Map<String, String>? headers}) async {
    try {
      final response = await http.post(
        Uri.parse('${env.apiPath}$url'),
        headers: headers ?? {'Content-Type': 'application/json', 'Accept': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isNotEmpty) {
          return json.decode(response.body); // داده‌های موفق
        } else {
          return null; // پاسخ خالی
        }
      } else {
        throw Exception('خطا در ارسال اطلاعات: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('خطا در درخواست POST: $e');
      throw Exception('خطا: $e');
    }
  }
}
