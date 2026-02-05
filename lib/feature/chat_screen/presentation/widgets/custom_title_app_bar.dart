import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/assets.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/app_text_styles.dart';

class CustomTitleAppBar extends StatelessWidget {
  const CustomTitleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          Assets.imagesRobot,
          height: 36.sp,
          width: 24.sp,
        ),
        20.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ChatGPT',
              style: AppTextStyles.font20Bold(context).copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            4.verticalSpace,
            Row(
              children: [
                Image.asset(
                  Assets.imagesEllipse,
                  height: 12.sp,
                  width: 12.sp,
                ),
                5.horizontalSpace,
                Text(
                  'Online',
                  style: AppTextStyles.font17Medium(context).copyWith(
                    color: AppColors.lightGreen,
                  ),
                ),
              ],
            ),
          ],
        ),
        ],
    );
  }
}
