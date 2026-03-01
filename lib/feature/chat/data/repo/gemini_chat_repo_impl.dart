import '../../domain/chat_repo.dart';
import '../model/chat_model.dart';
import '../service/gemini_chat_service.dart';
import 'gemini_chat_validation_mixin.dart';

class GeminiChatRepoImpl
    with ChatValidationMixin
    implements ChatRepo {

  final GeminiChatService geminiChatService;

  GeminiChatRepoImpl(this.geminiChatService);

  @override
  Future<ChatModel> sendMessage({required List<ChatModel> messages}) async {
    validateInput(messages);

    final response = await geminiChatService.sentMessage(messages);

    validateOutput(response);

    return response;
  }
}