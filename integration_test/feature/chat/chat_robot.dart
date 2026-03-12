import 'package:chat_bot/feature/chat/ui/page/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

class ChatRobot {
  final WidgetTester tester;

  ChatRobot({required this.tester});

  Future<void> runApp() async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: ChatScreen()),
      ),
    );

    await tester.pumpAndSettle();
  }

  Future<void> enterText({required String text}) async {
    final textField = find.byType(TextFormField);
    await tester.enterText(textField, text);
    await tester.pumpAndSettle();
  }

  Future<void> sendButton() async {
    final sendButton = find.byKey(const Key('sendButton'));
    await tester.tap(sendButton);
  }

  Future<void> tryAgain() async {
    final tryAgainButton = find.byKey(const Key('tryAgain'));
    await tester.tap(tryAgainButton);
    await tester.pumpAndSettle();
  }
}
