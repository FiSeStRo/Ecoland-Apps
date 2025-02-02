import 'dart:async';
import 'dart:convert';

import 'package:ecoland_application/providers/api/config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

const baseUrl = AppConfig.baseUrl;

class UserSettingsProvider with ChangeNotifier {
  String _accessToken = '';
  String _refreshToken = '';
  int refreshTime = 10;
  Timer? _refreshTokenTimer;
  // Getters
  get accessToken => _accessToken;
  get refreshToken => _refreshToken;

  void setAccessToken(String at, String rt) {
    _accessToken = at;
    notifyListeners();
    _refreshToken = rt;
    _refreshTokenTimer?.cancel();
    _refreshTokenTimer = Timer.periodic(
      const Duration(minutes: 10),
      (timer) => _refreshAccessToken(),
    );
  }

  Future<bool> signIn(String url, String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/authentication/sign-in'),
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final at = responseBody['accessToken'];
      final rt = responseBody['refreshToken'];
      setAccessToken(at, rt);
      return true;
    } else {
      throw Exception('Failed to sign in');
    }
  }

  Future<void> _refreshAccessToken() async {
    final response = await http.post(
      Uri.parse('$baseUrl/authentication/refresh-token'),
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

  @override
  void dispose() {
    _refreshTokenTimer?.cancel();
    super.dispose();
  }
}
