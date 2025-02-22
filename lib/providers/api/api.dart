import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  late Dio dio;

  String? _accessToken;

  ApiClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: getBaseUrl(),
      contentType: 'application/json',
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (_accessToken != null) {
          options.headers['Authorization'] = 'Bearer $_accessToken';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          //TODO: Add Refresh call
          print('unathorized transaction');
        }
        return handler.next(e);
      },
    ));
  }

  void setAccessToken(String token) {
    _accessToken = token;
  }

  Future<Response> get(String endpoint, {Map<String, dynamic>? query}) async {
    return await dio.get(endpoint, queryParameters: query);
  }

  Future<Response> post(String endpoint, {dynamic data}) async {
    return await dio.post(endpoint, data: data);
  }

  Future<Response> put(String endpoint, {dynamic data}) async {
    return await dio.put(endpoint, data: data);
  }

  Future<Response> patch(String endpoint, {dynamic data}) async {
    return await dio.patch(endpoint, data: data);
  }

  Future<Response> delete(String endpoint) async {
    return await dio.delete(endpoint);
  }

  String getBaseUrl() {
    if (kIsWeb) {
      return 'http://localhost:8081'; //Web
    } else if (Platform.isAndroid) {
      return 'http://10.0.2.2:8081'; // Android
    } else {
      return 'http://localhost:8081'; // Default
    }
  }
}
