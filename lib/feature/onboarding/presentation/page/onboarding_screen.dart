import 'package:chat_bot/core/helpers/extensions.dart';
import 'package:chat_bot/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../generated/assets.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          79.verticalSpace,
          Text(
            'You AI Assistant',
            style: AppTextStyles.font23Bold(context),
            textAlign: TextAlign.center,
          ),
          14.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 66.0),
            child: Text(
              'Using this software,you can ask your questions and receive articles using artificial intelligence assistant',
              style: AppTextStyles.font15Medium(
                context,
              ).copyWith(color: AppColors.grey),
              textAlign: TextAlign.center,
            ),
          ),
          84.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27.0),
            child: Image.asset(Assets.imagesOnboarding),
          ),
          130.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21.0),
            child: CustomButton(
              onPressed: () {
                context.pushNamed(Routes.chatScreen);
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Continue',
                      style: AppTextStyles.font19Bold(
                        context,
                      ).copyWith(color: AppColors.background),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Icon(
                    size: 24,
                    Icons.arrow_forward,
                    color: AppColors.background,
                  ),
                ],
              ),
            ),
          ),
          30.verticalSpace
        ],
      ),
    );
  }
}
