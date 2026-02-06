import 'package:chat_bot/feature/chat_screen/presentation/widgets/custom_container_button.dart';
import 'package:chat_bot/feature/chat_screen/presentation/widgets/custom_icon_and_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/assets.dart';
import '../cubit/chat_cubit.dart';

class CustomHelpScreen extends StatelessWidget {
  const CustomHelpScreen({super.key});

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
            onPressed: (){
              context.read<ChatCubit>().sendMessage("Explain Quantum physics");
            },),
        8.verticalSpace,
        CustomContainerButton(
          text: "What are wormholes explain like i am 5",
          onPressed: (){
            context.read<ChatCubit>().sendMessage("What are wormholes explain like i am 5");
          },),
        37.verticalSpace,
        CustomIconAndTitle(
            title: "Write & edit",
            imagePath: Assets.svgsEdit,
        ),
        CustomContainerButton(
            text: "Write a tweet about global warming",
            onPressed: (){
              context.read<ChatCubit>().sendMessage("Write a tweet about global warming");
            },),
        8.verticalSpace,
        CustomContainerButton(
          text: "Write a poem about flower and love",
          onPressed: (){
            context.read<ChatCubit>().sendMessage("Write a poem about flower and love");
          },),
        8.verticalSpace,
        CustomContainerButton(
          text: "Write a rap song lyrics about",
          onPressed: (){
            context.read<ChatCubit>().sendMessage("Write a rap song lyrics about");
          },),
        37.verticalSpace,
        CustomIconAndTitle(
          title: "Translate",
          imagePath: Assets.svgsTranslate,
        ),
        CustomContainerButton(
          text: "How do you say “how are you” in korean?",
          onPressed: (){
            context.read<ChatCubit>().sendMessage("How do you say “how are you” in korean?");
          },),
        8.verticalSpace,
        CustomContainerButton(
          text: "Write a poem about flower and love",
          onPressed: (){
            context.read<ChatCubit>().sendMessage("Write a poem about flower and love");
          },),
        8.verticalSpace,
        CustomContainerButton(
          text: "Write a rap song lyrics about",
          onPressed: (){
            context.read<ChatCubit>().sendMessage("Write a rap song lyrics about");
          },),
        37.verticalSpace,
      ],
    );
  }
}
