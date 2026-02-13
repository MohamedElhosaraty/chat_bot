import 'package:chat_bot/feature/chat/data/model/chat_model.dart';

abstract class ChatRepo {
  Future<ChatModel> sendMessage({required List<ChatModel> messages});
}
