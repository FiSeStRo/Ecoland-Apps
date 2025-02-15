import 'dart:convert';

import 'package:ecoland_application/providers/api/config.dart';
import 'package:http/http.dart';

class UserSettings {
  final String email;
  final String id;
  final String username;

  UserSettings({
    required this.email,
    required this.id,
    required this.username,
  });

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      email: json['email'],
      id: json['id'],
      username: json['username'],
    );
  }

  static Future<UserSettings> fetchUserSettings(String accessToken) async {
    final url = '${AppConfig.baseUrl}/user/info';
    Response response = await get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final Map<String, dynamic> decodedJson = jsonDecode(response.body);
      return UserSettings.fromJson(decodedJson);
    } else {
      throw Exception('Failed to load user settings');
    }
  }

  static Future<UserSettings> patchUserSettings(
    String accessToken, {
    String? username,
    String? newPassword,
    String? oldPassword,
    String? eMail,
  }) async {
    final url = '${AppConfig.baseUrl}/user/info';
    final body = <String, dynamic>{};

    if (username != null) body['username'] = username;
    if (newPassword != null) body['newPassword'] = newPassword;
    if (oldPassword != null) body['oldPassword'] = oldPassword;
    if (eMail != null) body['eMail'] = eMail;

    Response response = await patch(Uri.parse(url),
        headers: {'Authorization': 'Bearer $accessToken'},
        body: jsonEncode(body));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final Map<String, dynamic> decodedJson = jsonDecode(response.body);
      return UserSettings.fromJson(decodedJson);
    } else {
      throw Exception('Failed to update user settings');
    }
  }
}
