import 'package:chat_bot/feature/chat/data/model/chat_model.dart';
import 'package:chat_bot/feature/chat/data/repo/gemini_chat_repo_impl.dart';
import 'package:chat_bot/feature/chat/data/service/gemini_chat_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockGeminiChatService mockService;
  late GeminiChatRepoImpl repo;

  setUp(() {
    mockService = MockGeminiChatService();
    repo = GeminiChatRepoImpl(mockService);
  });

  group('input validation', () {
    test('Input validation - throws when messages list is empty', () {
      expect(
            () => repo.sendMessage(messages: []),
        throwsException,
      );

      verifyNever(() => mockService.sentMessage(any()));
    });

    test('Input validation - throws when message text is empty', () {
      final messages = [
        ChatModel(
          parts: [Parts(text: '   ')],
          role: 'user',
        ),
      ];

      expect(
            () => repo.sendMessage(messages: messages),
        throwsException,
      );

      verifyNever(() => mockService.sentMessage(any()));
    });

    test('Input validation - throws when message has more than one part', () {
      final messages = [
        ChatModel(
          parts: [Parts(text: 'Hello'), Parts(text: 'Hello')],
          role: 'user',
        ),
      ];

      expect(
            () => repo.sendMessage(messages: messages),
        throwsException,
      );

      verifyNever(() => mockService.sentMessage(any()));
    });

    test('Input validation - throws when role is empty', () {
      final messages = [
        ChatModel(
          parts: [Parts(text: 'Hello')],
          role: '   ',
        ),
      ];

      expect(
            () => repo.sendMessage(messages: messages),
        throwsException,
      );

      verifyNever(() => mockService.sentMessage(any()));
    });

    test('Input validation - throws when role is not one of user and model', () {
      final messages = [
        ChatModel(
          parts: [Parts(text: 'Hello')],
          role: 'admin',
        ),
      ];

      expect(
            () => repo.sendMessage(messages: messages),
        throwsException,
      );

      verifyNever(() => mockService.sentMessage(any()));
    });
  });

  group('output validation', () {
    test('Output validation - throws when response parts is empty', () async {
      final messages = [
        ChatModel(
          parts: [Parts(text: 'Hello')],
          role: 'user',
        ),
      ];

      final badResponse = ChatModel(
        role: 'assistant',
        parts: [],
      );

      when(() => mockService.sentMessage(any()))
          .thenAnswer((_) async => badResponse);

      expect(
            () => repo.sendMessage(messages: messages),
        throwsException,
      );

      verify(() => mockService.sentMessage(messages)).called(1);
    });

    test('Output validation - throws when response role is empty', () async {
      final messages = [
        ChatModel(
          parts: [Parts(text: 'Hello')],
          role: 'user',
        ),
      ];

      final badResponse = ChatModel(
        role: '   ',
        parts: [Parts(text: 'ok')],
      );

      when(() => mockService.sentMessage(any()))
          .thenAnswer((_) async => badResponse);

      expect(
            () => repo.sendMessage(messages: messages),
        throwsException,
      );

      verify(() => mockService.sentMessage(messages)).called(1);
    });

    test('Output validation - throws when response has more than one part', () async {
      final messages = [
        ChatModel(
          parts: [Parts(text: 'Hello')],
          role: 'user',
        ),
      ];
      final badResponse = ChatModel(
        role: 'user',
        parts: [Parts(text: 'ok'),
          Parts(text: 'name')],
      );

      when(() => mockService.sentMessage(any()))
          .thenAnswer((_) async => badResponse);

      expect(
            () => repo.sendMessage(messages: messages),
        throwsException,
      );

      verify(() => mockService.sentMessage(messages)).called(1);
    });

    test('Output validation - throws when response text is empty', () async {
      final messages = [
        ChatModel(
          parts: [Parts(text: 'Hello')],
          role: 'user',
        ),
      ];
      final badResponse = ChatModel(
        role: 'user',
        parts: [Parts(text: '')],
      );

      when(() => mockService.sentMessage(any()))
          .thenAnswer((_) async => badResponse);

      expect(
            () => repo.sendMessage(messages: messages),
        throwsException,
      );

      verify(() => mockService.sentMessage(messages)).called(1);
    });

    test('Output validation - throws when response role is not one of user and model', () async {
      final messages = [
        ChatModel(
          parts: [Parts(text: 'Hello')],
          role: 'user',
        ),
      ];
      final badResponse = ChatModel(
        role: 'admin',
        parts: [Parts(text: 'ok')],
      );

      when(() => mockService.sentMessage(any()))
          .thenAnswer((_) async => badResponse);

      expect(
            () => repo.sendMessage(messages: messages),
        throwsException,
      );

      verify(() => mockService.sentMessage(messages)).called(1);
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

      when(() => mockService.sentMessage(any()))
          .thenAnswer((_) async => expectedResponse);

      final result = await repo.sendMessage(messages: messages);

      expect(result, expectedResponse);
      verify(() => mockService.sentMessage(messages)).called(1);
    });

    test('success when multiple valid messages are sent', () async {
      final messages = [
        ChatModel(parts: [Parts(text: 'Hi')], role: 'user'),
        ChatModel(parts: [Parts(text: 'How are you?')], role: 'user'),
      ];

      final expectedResponse = ChatModel(
        role: 'user',
        parts: [Parts(text: 'ok')],
      );

      when(() => mockService.sentMessage(any()))
          .thenAnswer((_) async => expectedResponse);

      final result = await repo.sendMessage(messages: messages);

      expect(result, expectedResponse);
    });


  });
}


class MockGeminiChatService extends Mock
    implements GeminiChatService {}