import 'package:chat_bot/feature/chat/data/model/chat_model.dart';
import 'package:chat_bot/feature/chat/data/repo/gemini_chat_validation_mixin.dart';
import 'package:chat_bot/feature/chat/data/service/gemini_chat_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late ValidationTester validator;


  setUp(() {
    validator = ValidationTester();

  });

  group('input validation', () {
    test('Input validation - throws when messages list is empty', () {
      expect(
            () => validator.validateInput([]),
        throwsException,
      );
    });

    test('Input validation - throws when message text is empty', () {
      final messages = [
        ChatModel(
          parts: [Parts(text: '   ')],
          role: 'user',
        ),
      ];

      expect(
            () => validator.validateInput( messages),
        throwsException,
      );
    });

    test('Input validation - throws when message has more than one part', () {
      final messages = [
        ChatModel(
          parts: [Parts(text: 'Hello'), Parts(text: 'Hello')],
          role: 'user',
        ),
      ];

      expect(
            () => validator.validateInput( messages),
        throwsException,
      );

    });

    test('Input validation - throws when role is empty', () {
      final messages = [
        ChatModel(
          parts: [Parts(text: 'Hello')],
          role: '   ',
        ),
      ];

      expect(
            () => validator.validateInput( messages),
        throwsException,
      );

    });

    test('Input validation - throws when role is not one of user and model', () {
      final messages = [
        ChatModel(
          parts: [Parts(text: 'Hello')],
          role: 'admin',
        ),
      ];

      expect(
            () => validator.validateInput( messages),
        throwsException,
      );

    });
  });

  group('output validation', () {
    test('Output validation - throws when response parts is empty', () async {

      final badResponse = ChatModel(
        role: 'assistant',
        parts: [],
      );

      expect(
            () => validator.validateOutput( badResponse),
        throwsException,
      );

    });

    test('Output validation - throws when response role is empty', () async {

      final badResponse = ChatModel(
        role: '   ',
        parts: [Parts(text: 'ok')],
      );

      expect(
            () => validator.validateOutput( badResponse),
        throwsException,
      );

    });

    test('Output validation - throws when response has more than one part', () async {
      final badResponse = ChatModel(
        role: 'user',
        parts: [Parts(text: 'ok'),
          Parts(text: 'name')],
      );

      expect(
            () => validator.validateOutput( badResponse),
        throwsException,
      );

    });

    test('Output validation - throws when response text is empty', () async {

      final badResponse = ChatModel(
        role: 'user',
        parts: [Parts(text: '')],
      );

      expect(
            () => validator.validateOutput( badResponse),
        throwsException,
      );

    });

    test('Output validation - throws when response role is not one of user and model', () async {

      final badResponse = ChatModel(
        role: 'admin',
        parts: [Parts(text: 'ok')],
      );


      expect(
            () => validator.validateOutput( badResponse),
        throwsException,
      );

    });
  });

  group("Success Validation", (){
    test('Success - returns ChatModel when input and output are valid', () async {
      final messages = [
        ChatModel(
          parts: [Parts(text: 'Hello')],
          role: 'user',
        ),
      ];

      final expectedResponse = ChatModel(
        role: 'user',
        parts: [Parts(text: 'ok')],
      );


      expect(() => validator.validateInput(messages), returnsNormally);
      expect(() => validator.validateOutput(expectedResponse), returnsNormally);});

    test('success when multiple valid messages are sent', () async {
      final messages = [
        ChatModel(parts: [Parts(text: 'Hi')], role: 'user'),
        ChatModel(parts: [Parts(text: 'How are you?')], role: 'user'),
      ];

      final expectedResponse = ChatModel(
        role: 'user',
        parts: [Parts(text: 'ok')],
      );


      expect(() => validator.validateInput(messages), returnsNormally);
      expect(() => validator.validateOutput(expectedResponse), returnsNormally);
    });


  });
}


class MockGeminiChatService extends Mock
    implements GeminiChatService {}

class ValidationTester with ChatValidationMixin {}