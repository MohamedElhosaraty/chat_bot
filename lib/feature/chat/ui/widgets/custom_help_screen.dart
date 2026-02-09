import 'package:chat_bot/feature/chat/data/model/chat_model.dart';
import 'package:chat_bot/feature/chat/ui/cubit/chat_cubit.dart';
import 'package:chat_bot/feature/chat/ui/widgets/custom_container_button.dart';
import 'package:chat_bot/feature/chat/ui/widgets/custom_icon_and_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/assets.dart';

class CustomHelpScreen extends StatelessWidget {
  const CustomHelpScreen({super.key, required this.messages});

  final List<ChatModel> messages;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        19.verticalSpace,
        CustomIconAndTitle(
          title: "Explain",
          imagePath: Assets.svgsExplain,
        ),
        CustomContainerButton(
          text: "Explain Quantum physics",
          onPressed: () {
            final message = ChatModel(
                parts: [
                  Parts(text: "Explain Quantum physics"),
                ],
                role: 'user');
            context.read<ChatCubit>().sendMessage(
              messages:  messages..add(message),
            );
          },
        ),
        8.verticalSpace,
        CustomContainerButton(
          text: "What are wormholes explain like i am 5",
          onPressed: () {
            final message = ChatModel(
                parts: [
                  Parts(text: "What are wormholes explain like i am 5"),
                ],
                role: 'user'
            );
            context.read<ChatCubit>().sendMessage(
              messages:  messages..add(message),
            );
          },
        ),
        37.verticalSpace,
        CustomIconAndTitle(
          title: "Write & edit",
          imagePath: Assets.svgsEdit,
        ),
        CustomContainerButton(
          text: "Write a tweet about global warming",
          onPressed: () {
            final message = ChatModel(
                parts: [
                  Parts(
                      text: "Write a tweet about global warming"),
                ],
                role: 'user',
            );


            context.read<ChatCubit>().sendMessage(messages:  messages..add(message));
          },
        ),
        8.verticalSpace,
        CustomContainerButton(
          text: "Write a poem about flower and love",
          onPressed: () {
            final message = ChatModel(
                parts: [
                  Parts(text: "Write a poem about flower and love"),
                ],
                role: 'user');
            context.read<ChatCubit>().sendMessage(
              messages:  messages..add(message),
            );
          },
        ),
        8.verticalSpace,
        CustomContainerButton(
          text: "Write a rap song lyrics about",
          onPressed: () {
            final message = ChatModel(
                parts: [
                  Parts(text: "Write a rap song lyrics about"),
                ],
                role: 'user');

            context.read<ChatCubit>().sendMessage(
              messages: messages..add(message),
            );
          },
        ),
        37.verticalSpace,
        CustomIconAndTitle(
          title: "Translate",
          imagePath: Assets.svgsTranslate,
        ),
        CustomContainerButton(
          text: "How do you say “how are you” in korean?",
          onPressed: () {
            final message = ChatModel(
                parts: [
                  Parts(text: "How do you say “how are you” in korean?"),
                ],
                role: 'user');
            context.read<ChatCubit>().sendMessage(
              messages:  messages..add(message),
            );
          },
        ),
        8.verticalSpace,
        CustomContainerButton(
          text: "Write a poem about flower and love",
          onPressed: () {
            final message = ChatModel(
                parts: [
                  Parts(text: "Write a poem about flower and love"),
                ],
                role: 'user');

            context.read<ChatCubit>().sendMessage(
              messages:  messages..add(message),
            );
          },
        ),
        8.verticalSpace,
        CustomContainerButton(
          text: "Write a rap song lyrics about",
          onPressed: () {
            final message = ChatModel(
                parts: [
                  Parts(text: "Write a rap song lyrics about"),
                ],
                role: 'user');
            context.read<ChatCubit>().sendMessage(
              messages:  messages..add(message),
            );
          },
        ),
        37.verticalSpace,
      ],
    );
  }
}