import 'package:chat_bot/feature/chat/ui/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../widgets/chat_screen_app_bar.dart';
import '../widgets/chat_screen_body.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<ChatCubit>(),
        child: Column(
          children: [
            const ChatScreenAppBar(),
            const ChatScreenBody(),
          ],
        ),
      ),
    );
  }
}
