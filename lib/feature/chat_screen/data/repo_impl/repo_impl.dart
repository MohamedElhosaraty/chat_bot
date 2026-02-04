import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entity/chat_entity.dart';
import '../../domain/repository/chat_repository.dart';
import '../data_source/chat_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remote;

  ChatRepositoryImpl(this.remote);

  @override
  Future<Either<Failures, ChatEntity>> sendMessage(
    List<ChatEntity> messages,
  ) async {
    return await remote.sendToGemini(messages);
  }
}
