import 'package:chat_bot/feature/chat/ui/widgets/custom_container_robot.dart';
import 'package:chat_bot/feature/chat/ui/widgets/custom_failure_container.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../generated/assets.dart';
import '../../data/model/chat_model.dart';
import 'custom_container_message.dart';

class CustomListViewChatBody extends StatelessWidget {
  const CustomListViewChatBody({super.key, required this.scrollController, required this.messages, required this.isLoading, required this.isFailure});

  final ScrollController scrollController ;
  final List<ChatModel> messages;
  final bool isLoading ;
  final bool isFailure ;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      controller: scrollController,
      padding: const EdgeInsets.only(bottom: 60),
      physics: const BouncingScrollPhysics(),
      itemCount:
      messages.length + (isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        final newIndex = messages.length - (index + (isLoading || isFailure ? 0 : 1));
        if (isLoading &&
            index == 0) {
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
        if(isFailure && index == 0){
          return CustomFailureContainer(
              text: messages.last.parts?[0].text ?? '',
              messages: messages);
        }
        return Visibility(
          visible: !(isFailure && index == 1),
          child: CustomContainerMessage(
            text: messages[newIndex].parts?[0].text ?? '',
            index: index,
            isUser: messages[newIndex].role == 'user',
          ),
        );
      },
    );
  }
}
