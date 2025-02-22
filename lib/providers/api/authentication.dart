import 'dart:convert';

import 'package:ecoland_application/providers/api/api.dart';

Future<bool> signUp(String username, String email, String password) async {
  final url = '/authentication/sign-up';
  try {
    final Map<String, dynamic> object = {
      'username': username,
      'email': email,
      'password': password,
    };
    final response = await ApiClient().post(url, data: jsonEncode(object));
    if (response.statusCode == 201) {
      return true;
    } else {
      print(response.statusCode);
      print(response.data);
      return false;
    }
  } catch (e) {
    print(e);
    return false;
  }
}
