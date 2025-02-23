import 'dart:convert';
import 'package:ecoland_application/providers/api/api.dart';
import 'package:ecoland_application/providers/api/endpoints.dart';

Future<bool> signUp(String username, String email, String password) async {
  try {
    final Map<String, dynamic> object = {
      'username': username,
      'email': email,
      'password': password,
    };
    final response = await ApiClient()
        .post(Endpoints.authentication.signUp, data: jsonEncode(object));
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
