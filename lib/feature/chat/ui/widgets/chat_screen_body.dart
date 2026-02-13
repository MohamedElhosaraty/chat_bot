import 'package:chat_bot/feature/chat/data/model/chat_model.dart';
import 'package:chat_bot/feature/chat/ui/cubit/chat_cubit.dart';
import 'package:chat_bot/feature/chat/ui/widgets/custom_chat_text_field.dart';
import 'package:chat_bot/feature/chat/ui/widgets/custom_container_robot.dart';
import 'package:chat_bot/feature/chat/ui/widgets/custom_help_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/helpers/toast_helper.dart';
import '../../../../generated/assets.dart';
import 'custom_container_message.dart';

class ChatScreenBody extends StatefulWidget {
  const ChatScreenBody({super.key});

  @override
  State<ChatScreenBody> createState() => _ChatScreenBodyState();
}

class _ChatScreenBodyState extends State<ChatScreenBody> {

  final ScrollController _scrollController = ScrollController();
  List<ChatModel> messages = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ChatSuccess) {
          messages.add(state.chatModel);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          });
        }
        if (state is ChatFailure) {
          ToastHelper().showErrorToast(context, state.errorMessage);
        }
      },
      builder: (BuildContext context, ChatState state) {
        return BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            return Expanded(
              child: Stack(
                children: [
                  messages.isEmpty
                      ? CustomHelpScreen(messages: messages)
                      : Positioned(
                        bottom: 50,
                        right: 0,
                        left: 0,
                        top: 0,
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.only(bottom: 60),
                          physics: const BouncingScrollPhysics(),
                          itemCount:
                              messages.length + (state is ChatLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (state is ChatLoading &&
                                index == messages.length) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomContainerRobot(),
                                    Lottie.asset(
                                      Assets.lottieLoading,
                                      height: 80,
                                      width: 80,
                                    ),
                                  ],
                                ),
                              );
                            }
                            return CustomContainerMessage(
                              text: messages[index].parts?[0].text ?? '',
                              index: index,
                              isUser: messages[index].role == 'user',
                            );
                          },
                        ),
                      ),
                  CustomChatTextField(messages: messages),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
