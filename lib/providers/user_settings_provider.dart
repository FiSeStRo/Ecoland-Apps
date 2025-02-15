import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:ecoland_application/providers/api/config.dart';
import 'package:ecoland_application/providers/api/user_settings_api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UserSettingsProvider with ChangeNotifier {
  String _accessToken = '';
  String _refreshToken = '';
  int refreshTime = 10;
  Timer? _refreshTokenTimer;

  //UserSettings
  String _userName = '';
  String _eMail = '';

  // Getters

  get accessToken => _accessToken;
  get refreshToken => _refreshToken;
  get userName => _userName;
  get eMail => _eMail;
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

  Future<bool> signIn(String username, String password) async {
    bool success = false;
    final object = {'username': username, 'password': password};
    print(AppConfig.baseUrl);
    try {
      final response = await http.post(
        Uri.parse('${AppConfig.baseUrl}/authentication/sign-in'),
        body: jsonEncode(object),
      );
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final at = responseBody['accessToken'];
        final rt = responseBody['refreshToken'];
        setAccessToken(at, rt);
        success = true;
      } else {
        throw Exception('Failed to sign in');
      }
    } catch (e) {
      throw Exception("Call failed");
    }
    return success;
  }

  Future<void> _refreshAccessToken() async {
    final response = await http.post(
      Uri.parse('${AppConfig.baseUrl}/authentication/refresh-token'),
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

  Future<bool> LoadUserSettings() async {
    try {
      final settings = await UserSettings.fetchUserSettings(_accessToken);
      if (settings.username.isNotEmpty) _userName = settings.username;
      if (settings.email.isNotEmpty) _eMail = settings.email;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> UpdateUserSettings({
    String? username,
    String? newPassword,
    String? oldPassword,
    String? eMail,
  }) async {
    try {
      final settings = await UserSettings.patchUserSettings(
        _accessToken,
        username: username,
        newPassword: newPassword,
        oldPassword: oldPassword,
        eMail: eMail,
      );
      if (settings.username.isNotEmpty) _userName = settings.username;
      if (settings.email.isNotEmpty) _eMail = settings.email;
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void dispose() {
    _refreshTokenTimer?.cancel();
    super.dispose();
  }
}
