import 'package:dio/dio.dart';

import '../../config/app_config.dart';
import '../networking/api_constants.dart';

class ApiManager {
  final AppConfig appConfig;
  final Dio dio;

  ApiManager( {required this.dio,required this.appConfig});


  Future<Response> post({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    final response = await dio.post(
      appConfig.baseUrl + endPoint,
      data: data,
      queryParameters: {
        'key': ApiConstants.apiKey,
      },
    );

    return response;
  }

  Future<Response> get({required String endPoint}) async {
    final response = await dio.get(
      appConfig.baseUrl + endPoint,
    );

    return response;
  }

  Future<Response> delete({required String endPoint,required Map<String, dynamic> data,}) async {
    final response = await dio.delete(
      appConfig.baseUrl + endPoint,
      data: data,

    );

    return response;
  }

  Future<Response> patch({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    final response = await dio.patch(
      appConfig.baseUrl + endPoint,
      data: data,
    );

    return response;
  }
}
