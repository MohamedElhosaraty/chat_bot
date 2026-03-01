import '../model/chat_model.dart';

mixin ChatValidationMixin {
  static const _allowedRoles = {'user', 'model'};

  // Input Validation
  void validateInput(List<ChatModel> messages) {
    if (messages.isEmpty) {
      throw Exception('Messages list cannot be empty');
    }

    for (final message in messages) {
      if (message.parts == null || message.parts!.isEmpty) {
        throw Exception('Message parts cannot be empty');
      }

      final text = message.parts!.first.text;
      if (text == null || text.trim().isEmpty) {
        throw Exception('Message content cannot be empty');
      }

      final role = message.role;
      if (role == null || role.trim().isEmpty) {
        throw Exception('Message role cannot be empty');
      }

      if (!_allowedRoles.contains(role.trim())) {
        throw Exception('Message role should be one of $_allowedRoles');
      }

      if (message.parts!.length > 1) {
        throw Exception('Message should have only one part');
      }
    }
  }

  // Output Validation

  void validateOutput(ChatModel response) {
    if (response.parts == null || response.parts!.isEmpty) {
      throw Exception('Response parts cannot be empty');
    }

    final text = response.parts!.first.text;
    if (text == null || text.trim().isEmpty) {
      throw Exception('Response content cannot be empty');
    }

    final role = response.role;
    if (role == null || role.trim().isEmpty) {
      throw Exception('Response role cannot be empty');
    }

    if (!_allowedRoles.contains(role.trim())) {
      throw Exception('Response role should be one of $_allowedRoles');
    }

    if (response.parts!.length > 1) {
      throw Exception('Response should have only one part');
    }
  }
}