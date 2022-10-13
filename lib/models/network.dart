import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class APIRequest {
  static const String url = 'https://pastebin.com/raw/4LBfYGN6';
  dynamic objectDisplay;

  static Future<dynamic> fetch() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return compute((message) {
        print(message);
      }, response.body);
    } else if (response.statusCode == 400) {
      throw Exception('Not found');
    } else {
      throw Exception(Exception);
    }
  }
}
