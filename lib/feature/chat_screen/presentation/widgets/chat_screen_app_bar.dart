import 'package:chat_bot/feature/chat_screen/presentation/widgets/custom_action_app_bar.dart';
import 'package:chat_bot/feature/chat_screen/presentation/widgets/custom_title_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/app_colors.dart';

class ChatScreenAppBar extends StatelessWidget {
  const ChatScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        30.verticalSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 29.0),
          child: Row(
            children:  [
              IconButton(
                icon:  Icon(
                  size: 24.sp,
                  Icons.arrow_back,
                  color: AppColors.lightBlack,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              14.horizontalSpace,
              CustomTitleAppBar(),
              Spacer(),
              CustomActionAppBar(),
            ],
          ),
        ),
        13.verticalSpace,
        Divider(
          thickness: 1,
          color: AppColors.lightGrey,
        ),
      ],
    );
  }
}
