import 'package:chat_bot/feature/chat_screen/presentation/widgets/custom_chat_text_field.dart';
import 'package:chat_bot/feature/chat_screen/presentation/widgets/custom_container_robot.dart';
import 'package:chat_bot/feature/chat_screen/presentation/widgets/custom_help_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/helpers/toast_helper.dart';
import '../../../../generated/assets.dart';
import '../cubit/chat_cubit.dart';
import 'custom_container_message.dart';

class ChatScreenBody extends StatefulWidget {
  const ChatScreenBody({super.key});

  @override
  State<ChatScreenBody> createState() => _ChatScreenBodyState();
}

class _ChatScreenBodyState extends State<ChatScreenBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ChatSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          });
        }
        if (state is ChatError) {
          ToastHelper().showErrorToast(context, state.message);
        }
      },
      builder: (BuildContext context, ChatState state) {
        final cubit = context.read<ChatCubit>().messages;
        return BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            return Expanded(
              child: Stack(
                children: [
                  cubit.isEmpty ? const CustomHelpScreen() : Positioned(
                    bottom: 50,
                    right: 0,
                    left: 0,
                    top: 0,
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(bottom: 60),
                      physics: const BouncingScrollPhysics(),
                      itemCount: cubit.length,
                      itemBuilder: (context, index) {
                        return context.watch<ChatCubit>().messages.isEmpty ? const CustomHelpScreen() :
                        CustomContainerMessage(
                          index: index,
                          isUser: cubit[index].isUser,
                        );
                      },
                    ),
                  ),
                  if (state is ChatLoading)
                    Positioned(
                      bottom: 90,
                      right: 0,
                      left: 10,
                      child: Row(
                        children: [
                          CustomContainerRobot(),
                          Lottie.asset(
                            Assets.lottieLoading,
                            height: 80,
                            width: 80,
                          ),
                        ],
                      ),
                    ),
                  CustomChatTextField(),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
