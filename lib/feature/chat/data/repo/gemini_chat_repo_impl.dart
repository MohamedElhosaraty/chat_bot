import 'package:chat_bot/feature/chat/data/model/chat_model.dart';
import 'package:chat_bot/feature/chat/data/service/gemini_chat_service.dart';
import 'package:chat_bot/feature/chat/domain/chat_repo.dart';

class GeminiChatRepoImpl implements ChatRepo {
  final GeminiChatService geminiChatService;

  GeminiChatRepoImpl(this.geminiChatService);

  @override
  Future<ChatModel> sendMessage({required List<ChatModel> messages}) async {
    final allowedRoles = {'user', 'model'};
    // input validation
    if (messages.isEmpty) {
      throw Exception('Messages list cannot be empty');
    }

    for (final message in messages) {
      if (message.parts!.first.text!.trim().isEmpty) {
        throw Exception('Message content cannot be empty');
      }
      if (!allowedRoles.contains(message.role!.trim())) {
        throw Exception('Message role should be one of $allowedRoles');
      }
      if (message.parts!.length > 1) {
        throw Exception('Message should have only one part');
      }
      if (message.role!.trim().isEmpty) {
        throw Exception('Message role cannot be empty');
      }
    }
    final response = await geminiChatService.sentMessage(messages);

    // output validation
    if (response.parts == null || response.parts!.isEmpty) {
      throw Exception('Response parts cannot be empty');
    }
    if (response.role == null || response.role!.trim().isEmpty) {
      throw Exception('Response role cannot be empty');
    }
    if(response.parts!.first.text!.trim().isEmpty) {
      throw Exception('Response content cannot be empty');
    }
    if (!allowedRoles.contains(response.role!.trim())) {
      throw Exception('Response role should be one of $allowedRoles');
    }
    if (response.parts!.length > 1) {
      throw Exception('Response should have only one part');
    }

    return response;

  }

}