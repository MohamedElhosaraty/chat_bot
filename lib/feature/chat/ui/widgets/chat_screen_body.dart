import 'package:chat_bot/feature/chat/data/model/chat_model.dart';
import 'package:chat_bot/feature/chat/ui/cubit/chat_cubit.dart';
import 'package:chat_bot/feature/chat/ui/widgets/custom_chat_text_field.dart';
import 'package:chat_bot/feature/chat/ui/widgets/custom_help_screen.dart';
import 'package:chat_bot/feature/chat/ui/widgets/custom_list_view_chat_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/toast_helper.dart';


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
              _scrollController.position.minScrollExtent,
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
                        child: CustomListViewChatBody(
                            scrollController: _scrollController,
                            messages: messages,
                            isLoading: state is ChatLoading,
                            isFailure: state is ChatFailure,
                        ),
                      ),
                  CustomChatTextField(
                      messages: messages,
                  isFailure: state is ChatFailure,),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
