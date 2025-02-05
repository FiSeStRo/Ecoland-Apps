import 'dart:convert';

import 'package:http/http.dart';
import './config.dart';

Future<bool> signUp(String username, String email, String password) async {
  final url = '${AppConfig.baseUrl}/authentication/sign-up';
  try {
    final Map<String, dynamic> object = {
      'username': username,
      'email': email,
      'password': password,
    };
    Response response = await post(Uri.parse(url), body: jsonEncode(object));
    if (response.statusCode == 201) {
      return true;
    } else {
      print(response.statusCode);
      print(response.body);
      return false;
    }
  } catch (e) {
    print(e);
    return false;
  }
}
