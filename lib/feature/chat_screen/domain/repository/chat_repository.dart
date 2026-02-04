import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entity/chat_entity.dart';

abstract class ChatRepository {
  Future<Either<Failures, ChatEntity>> sendMessage(
      List<ChatEntity> messages);
}
