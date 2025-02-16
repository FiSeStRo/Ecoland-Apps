import 'dart:convert';

import 'package:ecoland_application/providers/api/config.dart';
import 'package:http/http.dart';

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

  static Future<UserSettingsApi> fetchUserSettings(
      String accessToken, int id) async {
    final uri = Uri.parse('${AppConfig.baseUrl}/user/info')
        .replace(queryParameters: {"id": id});
    print("fetching userSettings from ${uri}");
    Response response = await get(
      uri,
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final Map<String, dynamic> decodedJson = jsonDecode(response.body);
      print('decoded json user settigns ${decodedJson}');
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
      final url = '${AppConfig.baseUrl}/user/info';
      final body = <String, dynamic>{};

      if (username != null) body['username'] = username;
      if (newPassword != null) body['newPassword'] = newPassword;
      if (oldPassword != null) body['oldPassword'] = oldPassword;
      if (eMail != null) body['eMail'] = eMail;
      body["id"] = id;
      print("reqBody${jsonEncode(body)}");
      print("url $url");
      print("accessToken $accessToken");
      final response = await patch(Uri.parse(url),
          headers: {'Authorization': 'Bearer $accessToken'},
          body: jsonEncode(body));
      print("responseStatus ${response.statusCode}");
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> decodedJson = jsonDecode(response.body);
        return UserSettingsApi.fromJson(decodedJson);
      } else {
        throw Exception('Failed to update user settings');
      }
    } catch (e) {
      print("failed with $e");
      throw Exception("Failed to call api");
    }
  }
}
