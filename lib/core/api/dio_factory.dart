import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../helpers/shared_pref_helper.dart';
import '../helpers/shared_prefs_keys.dart';

class DioFactory {
  DioFactory._();

  static Dio? dio;

  static Future<void> init() async {
    Duration timeOut = const Duration(minutes: 1);

    dio = Dio();
    dio!.options
      ..connectTimeout = timeOut
      ..receiveTimeout = timeOut;

    await _addDioHeaders();
    _addDioInterceptor();
  }

  static Dio getDio() {
    if (dio == null) {
      throw Exception("Dio is not initialized. Call DioFactory.init() first.");
    }
    return dio!;
  }

  static Future<void> _addDioHeaders() async {
    final token = await SharedPrefHelper.getSecuredString(SharedPrefsKeys.tokenKey);
    dio?.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    debugPrint("Headers have been set into Dio with token: $token");
  }

  static void setTokenIntoHeaderAfterLogin(String token) {
    dio?.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    debugPrint("Token has been set into header");
  }

  static void _addDioInterceptor() {
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }
}
