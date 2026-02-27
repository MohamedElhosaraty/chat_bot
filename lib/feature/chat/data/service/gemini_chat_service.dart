import 'package:dio/dio.dart';

import '../../../../core/api/api_manager.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/networking/api_constants.dart';
import '../model/chat_model.dart';

class GeminiChatService {
  final ApiManager apiManager;
  GeminiChatService({required this.apiManager});

  static const int _maxRetries = 5;

  Future<ChatModel> sentMessage(List<ChatModel> messages) async {
    int attempt = 0;

    while (true) {
      try {
        final response = await apiManager.post(
          endPoint: ApiConstants.generateText,
          data: {
            "contents": messages.map((e) => e.toJson()).toList(),
          },
        );

        final candidate = response.data['candidates'][0];
        return ChatModel.fromJson(candidate['content']);

      } catch (e) {
        attempt++;
        if (e is DioException) {
          if (!_shouldRetry(e) || attempt >= _maxRetries) {
            throw ServerFailure.fromDioException(e);
          }
        } else {
          throw ServerFailure(error: e.toString());
        }
        await Future.delayed(Duration(milliseconds: 300 * attempt));
      }
    }
  }

  bool _shouldRetry(DioException e) {
    final statusCode = e.response?.statusCode;
    if (statusCode != null && statusCode >= 400 && statusCode < 500) return false;
    return e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError ||
        (statusCode != null && statusCode >= 500);
  }
}