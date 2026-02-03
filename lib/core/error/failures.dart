import 'package:dio/dio.dart';

abstract class Failures {
  final String error;

  const Failures({required this.error});
}

class ServerFailure extends Failures {
  ServerFailure({required super.error});

  factory ServerFailure.fromDioException(DioException error) {
    String errorMessage = 'There was an error';

    switch (error.type) {
      case DioExceptionType.badCertificate:
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          error.response!.statusCode!,
          error.response!.data,
        );

      case DioExceptionType.receiveTimeout:
        errorMessage = 'Server timeout, please try again.';
        break;

      case DioExceptionType.cancel:
      case DioExceptionType.connectionError:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Please check your internet connection and try again.';
        break;

      case DioExceptionType.unknown:
        errorMessage = 'Unknown error occurred';
        break;

      }

    return ServerFailure(error: errorMessage);
  }

  factory ServerFailure.fromResponse(
      int statusCode,
      dynamic errorResponseBody,
      ) {
    final message = errorResponseBody['message'];
    final errorMap = errorResponseBody['errors'] ??
        (errorResponseBody['data'] is Map
            ? errorResponseBody['data']
            : null);

    final errorMessage = errorMap != null
        ? parseErrorResponse(errorMap as Map<String, dynamic>)
        : message ?? 'Something went wrong, please try again.';

    return ServerFailure(error: errorMessage);
  }
}

String parseErrorResponse(Map<String, dynamic> errorResponse) {
  return errorResponse.values
      .expand((messages) => messages as List)
      .join('\n');
}

class CacheFailure extends Failures {
  CacheFailure({required super.error});

  factory CacheFailure.fromException(Exception error) {
    return CacheFailure(error: error.toString());
  }
}
