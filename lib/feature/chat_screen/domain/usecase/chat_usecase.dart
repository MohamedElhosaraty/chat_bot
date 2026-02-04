import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entity/chat_entity.dart';
import '../repository/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<Either<Failures, ChatEntity>> call(
      List<ChatEntity> messages) async {
    return repository.sendMessage(messages);
  }
}
