import 'package:chat_bot/core/api/api_manager.dart';
import 'package:chat_bot/feature/chat/data/model/chat_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/networking/api_constants.dart';

class GeminiChatService {
  final ApiManager apiManager;

  GeminiChatService({required this.apiManager});

  Future<ChatModel> sentMessage(List<ChatModel> message) async {
    try {
      final response = await apiManager.post(
        endPoint: ApiConstants.generateText,
        data: {
          "contents": message.map((e) => e.toJson()).toList(),
        },
      );

      return ChatModel.fromJson(response.data['candidates'][0]['content']);
    } catch (e) {
      if (e is DioException) {
        throw ServerFailure.fromDioException(e);
      } else {
        throw ServerFailure(error: e.toString());
      }
    }

  }
}