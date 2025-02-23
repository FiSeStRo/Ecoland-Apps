import 'dart:async';
import 'package:ecoland_application/providers/api/user_settings_api.dart';
import 'package:flutter/material.dart';

class UserSettingsProvider with ChangeNotifier {
  int _id = 0;
  int refreshTime = 10;
  Timer? _refreshTokenTimer;
  String _userName = '';
  String _eMail = '';

  // Getters
  String get userName => _userName;
  String get eMail => _eMail;
  int get id => _id;

  // Setters
  set userName(String value) {
    _userName = value;
    notifyListeners();
  }

  set id(int value) {
    _id = value;
    notifyListeners();
  }

  Future<bool> loadUserSettings() async {
    try {
      print("loadUserSettings");
      print("id $_id");
      final settings = await UserSettingsApi.fetchUserSettings(_id);
      if (settings.username.isNotEmpty) _userName = settings.username;
      if (settings.email.isNotEmpty) _eMail = settings.email;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUserSettings({
    String? username,
    String? newPassword,
    String? oldPassword,
    String? eMail,
  }) async {
    try {
      print("udateUserSettings");
      final settings = await UserSettingsApi.patchUserSettings(
        username: username,
        newPassword: newPassword,
        oldPassword: oldPassword,
        eMail: eMail,
      );
      print("userName ${settings.username}");
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
