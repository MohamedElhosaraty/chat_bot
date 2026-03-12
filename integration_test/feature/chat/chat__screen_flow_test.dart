import 'package:chat_bot/core/di/dependency_injection.dart';
import 'package:chat_bot/feature/chat/data/model/chat_model.dart';
import 'package:chat_bot/feature/chat/domain/chat_repo.dart';
import 'package:chat_bot/feature/chat/ui/widgets/custom_container_message.dart';
import 'package:chat_bot/feature/chat/ui/widgets/custom_failure_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'chat_robot.dart';

class ChatMockRepo extends Mock implements ChatRepo {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late ChatMockRepo chatMockRepo;

  setUp(() async {
    await getIt.reset();
    setupGetIt();
    getIt.unregister<ChatRepo>();
    chatMockRepo = ChatMockRepo();
    getIt.registerLazySingleton<ChatRepo>(()=> chatMockRepo);
  });

  group('Integration Test - ChatScreen', () {

    testWidgets('Send a message and show loading', (WidgetTester tester) async {
      ChatRobot chatRobot = ChatRobot(tester: tester);
      when(() => chatMockRepo.sendMessage(messages: any(named: 'messages')))
          .thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 2));
        return ChatModel(parts: [Parts(text: 'ok ok Response')], role: 'model');
      });

      await chatRobot.runApp();
      await chatRobot.enterText(text: 'Hello Mohamed');
      await chatRobot.sendButton();
      await tester.pump();
      expect(find.byType(CustomContainerMessage), findsOneWidget);
      expect(find.byKey(const Key('loadingChatScreen')), findsOneWidget);
    });

    testWidgets('Send a message and receive bot response', (WidgetTester tester) async {
      ChatRobot chatRobot = ChatRobot(tester: tester);
      when(() => chatMockRepo.sendMessage(messages: any(named: 'messages')))
          .thenAnswer((_) async {
            return Future.delayed(
              const Duration(seconds: 2),
                  () => ChatModel(parts: [Parts(text: 'ok ok Response')], role: 'model'),
            );
      } );

      await chatRobot.runApp();
      await chatRobot.enterText(text: 'Hello Mohamed');
      await chatRobot.sendButton();
      await tester.pumpAndSettle();
      expect(find.descendant(of: find.byType(CustomContainerMessage), matching: find.text('Hello Mohamed')), findsOneWidget);
      expect(find.descendant(of: find.byType(CustomContainerMessage), matching: find.text('ok ok Response')), findsOneWidget);
    });

    testWidgets('Send a message and receive failure response', (WidgetTester tester) async {
      ChatRobot chatRobot = ChatRobot(tester: tester);
      when(() => chatMockRepo.sendMessage(messages: any(named: 'messages')))
          .thenAnswer((_) async {
            return Future.delayed(
              const Duration(seconds: 2),
                  () => throw Exception('Something went wrong'),
            );
      } );

      await chatRobot.runApp();
      await chatRobot.enterText(text: 'Hello Mohamed');
      await chatRobot.sendButton();
      await tester.pumpAndSettle();
      expect(find.descendant(of: find.byType(CustomFailureContainer), matching: find.text('Hello Mohamed')), findsOneWidget);
    });

    testWidgets('Send a message and receive failure response and make try again then receive response', (WidgetTester tester) async {
      ChatRobot chatRobot = ChatRobot(tester: tester);
      var counter = 0;
      when(() => chatMockRepo.sendMessage(messages: any(named: 'messages')))
          .thenAnswer((_) async {
            return Future.delayed(
              const Duration(seconds: 2),
                  () => counter++ == 0 ? throw Exception('Something went wrong') :
                  ChatModel(parts: [Parts(text: 'ok ok Response')], role: 'model'),
            );
      } );

      await chatRobot.runApp();
      await chatRobot.enterText(text: 'Hello Mohamed');
      await chatRobot.sendButton();
      await tester.pumpAndSettle();
      await chatRobot.tryAgain();
      expect(find.descendant(of: find.byType(CustomContainerMessage), matching: find.text('Hello Mohamed')), findsOneWidget);
      expect(find.descendant(of: find.byType(CustomContainerMessage), matching: find.text('ok ok Response')), findsOneWidget);
    });

    testWidgets('Send a message 5 times and  then receive response', (WidgetTester tester) async {
      ChatRobot chatRobot = ChatRobot(tester: tester);
      var counter = 0;
      when(() => chatMockRepo.sendMessage(messages: any(named: 'messages')))
          .thenAnswer((_) async {
            await Future.delayed(
              const Duration(seconds: 2),() {},
            );
            counter++;
            if (counter == 4) {
              return throw Exception('Something went wrong');
            } else {
              return ChatModel(parts: [Parts(text: 'ok ok Response')], role: 'model');
            }
      } );

      await chatRobot.runApp();
      await chatRobot.enterText(text: 'Hello Mohamed');
      await chatRobot.sendButton();
      await tester.pumpAndSettle();
      await chatRobot.enterText(text: 'Hello Mohamed');
      await chatRobot.sendButton();
      await tester.pumpAndSettle();
      await chatRobot.enterText(text: 'Hello Mohamed');
      await chatRobot.sendButton();
      await tester.pumpAndSettle();
      await chatRobot.enterText(text: 'Hello Mohamed');
      await chatRobot.sendButton();
      await tester.pumpAndSettle();
      await chatRobot.enterText(text: 'Hello Mohamed');
      await chatRobot.sendButton();
      await tester.pumpAndSettle();
      expect(find.descendant(of: find.byType(CustomContainerMessage), matching: find.text('Hello Mohamed')), findsExactly(4));
      expect(find.descendant(of: find.byType(CustomFailureContainer), matching: find.text('Hello Mohamed')), findsOneWidget);
    });
  });
}