import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../generated/assets.dart';
import '../cubit/chat_cubit.dart';


class CustomChatTextField extends StatefulWidget {
  const CustomChatTextField({super.key,});

  @override
  State<CustomChatTextField> createState() => _CustomChatTextFieldState();
}

class _CustomChatTextFieldState extends State<CustomChatTextField> {

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 36.h,
      right: 24.w,
      left: 18.w,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.13),
              offset: const Offset(5, 4),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
        ),
        child: CustomTextField(
          textController: textController,
          labelText: 'Write your message',
          maxLines: 5,
          keyboardType: TextInputType.multiline,
          style: AppTextStyles.font16Bold(context),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  Assets.imagesMicrophone,
                  scale: .8,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (textController.text.isNotEmpty) {
                    //FocusScope.of(context).unfocus();
                    context.read<ChatCubit>().sendMessage(textController.text);
                    textController.clear();
                  }
                },
                icon: Image.asset(
                  Assets.imagesSend,
                  scale:  .8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
