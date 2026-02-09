import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../generated/assets.dart';



class CustomActionAppBar extends StatelessWidget {
  const CustomActionAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          Assets.imagesVolume,
          height: 24.sp,
          width: 24.sp,
        ),
        19.horizontalSpace,
        Image.asset(
          Assets.imagesExport,
          height: 24.sp,
          width: 24.sp,
        ),
      ],
    );
  }
}
