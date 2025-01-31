import 'package:http/http.dart';
import './config.dart';

Future<bool> signUp(String username, String email, String password) async {
  const baseUrl = AppConfig.baseUrl;
  const url = '$baseUrl/authentication/sign-up';
  try {
    Response response = await post(Uri.parse(url), body: {
      'username': username,
      'email': email,
      'password': password,
    });

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
