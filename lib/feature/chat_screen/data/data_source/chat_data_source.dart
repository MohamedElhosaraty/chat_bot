import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/api/api_manager.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/networking/api_constants.dart';
import '../../domain/entity/chat_entity.dart';
import '../model/chat_model.dart';

abstract class ChatRemoteDataSource {
  Future<Either<Failures, ChatEntity>> sendToGemini(List<ChatEntity> messages);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final ApiManager apiManager;

  ChatRemoteDataSourceImpl(this.apiManager);

  @override
  Future<Either<Failures, ChatEntity>> sendToGemini(List<ChatEntity> messages) async {
    try {
      final chatModels = messages
          .map((e) => ChatModel(text: e.text, isUser: e.isUser))
          .toList();

      final response = await apiManager.post(
        endPoint: ApiConstants.generateText,
        data: {
          "contents": chatModels.map((e) => e.toGeminiJson()).toList(),
        },
      );
      final data = ChatModel.fromJson(
          response.data['candidates'][0]['content']['parts'][0]);
      return right(data);
    }catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(error: e.toString()));
      }
    }

  }
}
