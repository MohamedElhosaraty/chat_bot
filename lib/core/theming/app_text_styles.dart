import 'dart:ui';

import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_font_weights.dart';
import 'app_text_size.dart';

class AppTextStyles {
  static const Color textColor = AppColors.primaryColor;
  static const String _fontFamily = 'Nunito';

  static TextStyle baseStyle({
    required FontWeight fontWeight,
    required double fontSize,
    FontStyle? fontStyle,
    BuildContext? context,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      color: textColor,
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontStyle: fontStyle ?? FontStyle.normal,
    );
  }

  static TextStyle font23Bold(BuildContext context) => baseStyle(
    fontWeight: AppFontWeights.fontWeightBold,
    fontSize: AppTextSizes.fontSize23,
  );

  static TextStyle font15Medium(BuildContext context) => baseStyle(
    fontWeight: AppFontWeights.fontWeightMedium,
    fontSize: AppTextSizes.fontSize15,
  );

  static TextStyle font17Medium(BuildContext context) => baseStyle(
    fontWeight: AppFontWeights.fontWeightMedium,
    fontSize: AppTextSizes.fontSize17,
  );

  static TextStyle font19Bold(BuildContext context) => baseStyle(
    fontWeight: AppFontWeights.fontWeightBold,
    fontSize: AppTextSizes.fontSize19,
  );

  static TextStyle font20Bold(BuildContext context) => baseStyle(
    fontWeight: AppFontWeights.fontWeightBold,
    fontSize: AppTextSizes.fontSize20,
  );

  static TextStyle font13Bold(BuildContext context) => baseStyle(
    fontWeight: AppFontWeights.fontWeightBold,
    fontSize: AppTextSizes.fontSize13,
  );

  static TextStyle font16Bold(BuildContext context) => baseStyle(
    fontWeight: AppFontWeights.fontWeightBold,
    fontSize: AppTextSizes.fontSize16,
  );


}
