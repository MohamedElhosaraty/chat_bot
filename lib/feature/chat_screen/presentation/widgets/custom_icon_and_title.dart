import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class CustomIconAndTitle extends StatelessWidget {
  const CustomIconAndTitle({super.key, required this.title, required this.imagePath});

  final String title;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(imagePath),
        5.verticalSpace,
        Text(
          title,
          style: AppTextStyles.font16Bold(context).copyWith(
            color: AppColors.lighterBlack,
          ),
        ),
        18.verticalSpace
      ],
    );
  }
}
