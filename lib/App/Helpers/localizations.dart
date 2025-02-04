import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../env.dart'; // فرض می‌کنیم env.dart اینجا است

Future<Map<String, String>> getLang() async {

  final response = await http.get(Uri.parse('${env.apiPath}lang/${env.local}'));

  if (response.statusCode == 200) {
    Map<String, dynamic> translations = json.decode(response.body);
    return translations.map((key, value) => MapEntry(key, value.toString()));
  } else {
    throw Exception('Failed to load translations');
  }
}
