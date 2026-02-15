import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../data/model/chat_model.dart';
import '../cubit/chat_cubit.dart';

class CustomFailureContainer extends StatelessWidget {
  const CustomFailureContainer({super.key, required this.text, required this.messages});

  final String text;
  final List<ChatModel> messages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.4, right: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        decoration: BoxDecoration(
          color: AppColors.red.withOpacity(0.2),
          border: Border.all(color: AppColors.red),
          borderRadius: BorderRadius.circular(
            20.r,
          ),
        ),
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: AppTextStyles.font16Bold(
                context,
              ).copyWith(color: AppColors.black),
            ),
            5.verticalSpace,
            Text(
              "Error",
              style: AppTextStyles.font16Bold(
                context,
              ).copyWith(color: AppColors.red),
            ),
            5.verticalSpace,
            InkWell(
              onTap: (){
                context.read<ChatCubit>().sendMessage(
                  messages: messages,
                );
              },
              child: Text(
                'Try again',
                style: AppTextStyles.font16Bold(
                  context,
                ).copyWith(color: AppColors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
