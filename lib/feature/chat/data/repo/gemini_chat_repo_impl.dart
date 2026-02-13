import 'package:chat_bot/feature/chat/data/model/chat_model.dart';
import 'package:chat_bot/feature/chat/data/service/gemini_chat_service.dart';
import 'package:chat_bot/feature/chat/domain/chat_repo.dart';

class GeminiChatRepoImpl implements ChatRepo {
  final GeminiChatService geminiChatService;

  GeminiChatRepoImpl(this.geminiChatService);

  @override
  Future<ChatModel> sendMessage({required List<ChatModel> messages}) async{
     return await geminiChatService.sentMessage(messages);
  }
}