import '../../domain/entity/chat_entity.dart';

class ChatModel extends ChatEntity {
  ChatModel({required super.text, required super.isUser});

  Map<String, dynamic> toGeminiJson() {
    return {
      "parts": [
        {"text": text}
      ]
    };
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      text: json['text'] ?? '',
      isUser: false,
    );
  }
}
