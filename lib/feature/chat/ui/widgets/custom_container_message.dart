import 'package:chat_bot/feature/chat/ui/widgets/custom_container_robot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class CustomContainerMessage extends StatelessWidget {
  const CustomContainerMessage({super.key, required this.index, required this.isUser, required this.text, });

  final int index;
  final bool isUser;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: isUser ?  EdgeInsets.only(left: 55.w, right: 29.w) :  EdgeInsets.only(left: 62.w, right: 62.w),
          child: Align(
            alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
              margin: const EdgeInsets.only(bottom: 35),
              decoration: BoxDecoration(
                color: isUser ? AppColors.primaryColor : AppColors.lighterGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular( isUser ? 30.r : 25.r),
                  bottomRight: Radius.circular(isUser ? 30.r : 25.r),
                  bottomLeft: Radius.circular(isUser ? 30.r : 0.r),
                  topRight: Radius.circular(isUser ? 0.r : 25.r),
                ),
              ),
              child: Text(
                text,
                style: AppTextStyles.font16Bold(
                  context,
                ).copyWith(color: isUser ? AppColors.background : AppColors.darkGrey),
              ),
            ),
          ),
        ),
        isUser ? const SizedBox.shrink() : Positioned(
          bottom: 15,
          left: 29,
          child: CustomContainerRobot(),
        ),
      ],
    );
  }
}
