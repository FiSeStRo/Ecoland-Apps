import 'dart:async';
import 'dart:convert';
import 'package:ecoland_application/providers/api/api.dart';
import 'package:ecoland_application/providers/api/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String _accessToken = '';
  String _refreshToken = '';
  int refreshTime = 10;
  Timer? _refreshTokenTimer;

  void setAccessToken(String at, String rt) {
    _accessToken = at;
    _refreshToken = rt;
    ApiClient().setAccessToken(at);
    notifyListeners();
    _refreshTokenTimer?.cancel();
    _refreshTokenTimer = Timer.periodic(
      const Duration(minutes: 10),
      (timer) => _refreshAccessToken(),
    );
  }

  //Getters
  get accessToken => _accessToken;

  Future<void> _refreshAccessToken() async {
    final response = await http.post(
      Uri.parse('/authentication/refresh-token'),
      headers: {'Authorization': 'Bearer $_refreshToken'},
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final at = responseBody['accessToken'];
      final rt = responseBody['refreshToken'];
      setAccessToken(at, rt);
    } else {
      throw Exception('Failed to refresh token');
    }
  }

  Future<dynamic> signIn(String username, String password) async {
    final object = {'username': username, 'password': password};
    try {
      final response =
          await ApiClient().post(Endpoints.authentication.signIn, data: object);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.data);
        final at = data['accessToken'];
        final rt = data['refreshToken'];
        notifyListeners();
        print("Id set to ${data.id}");
        setAccessToken(at, rt);
        return {"id": data.id};
      } else {
        throw Exception('Failed to sign in');
      }
    } catch (e) {
      throw Exception("Call failed");
    }
  }
}
