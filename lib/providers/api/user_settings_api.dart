import 'dart:convert';

import 'package:ecoland_application/providers/api/api.dart';

class UserSettingsApi {
  final String email;
  final String id;
  final String username;

  UserSettingsApi({
    required this.email,
    required this.id,
    required this.username,
  });

  factory UserSettingsApi.fromJson(Map<String, dynamic> json) {
    return UserSettingsApi(
      email: json['email'],
      id: json['id'],
      username: json['username'],
    );
  }

  static Future<UserSettingsApi> fetchUserSettings(int id) async {
    print("fetching userSettings from");
    final response = await ApiClient().get('/user/info', query: {"id": id});
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      final Map<String, dynamic> decodedJson = jsonDecode(response.data);
      print('decoded json user settigns $decodedJson');
      return UserSettingsApi.fromJson(decodedJson);
    } else {
      throw Exception('Failed to load user settings');
    }
  }

  static Future<UserSettingsApi> patchUserSettings(
    String accessToken,
    int id, {
    String? username,
    String? newPassword,
    String? oldPassword,
    String? eMail,
  }) async {
    print("Patch UserSettings");
    try {
      final data = <String, dynamic>{};

      if (username != null) data['username'] = username;
      if (newPassword != null) data['newPassword'] = newPassword;
      if (oldPassword != null) data['oldPassword'] = oldPassword;
      if (eMail != null) data['eMail'] = eMail;
      data["id"] = id;

      print("Request Body: $data");
      print("AccessToken: $accessToken");

      final response = await ApiClient().patch("/user/info", data: data);

      print("Response Status: ${response.statusCode}");
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return UserSettingsApi.fromJson(response.data);
      } else {
        throw Exception('Failed to update user settings');
      }
    } catch (e) {
      print("Failed with: $e");
      throw Exception("Failed to call API");
    }
  }
}
