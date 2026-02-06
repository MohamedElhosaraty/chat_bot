import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/assets.dart';

class CustomContainerRobot extends StatelessWidget {
  const CustomContainerRobot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 1.96),
            blurRadius: 1.96,
            spreadRadius: 0,
          ),
        ],
      ),

      child: Image.asset(
        Assets.imagesRobot,
        height: 24.sp,
        width: 24.sp,
      ),
    );
  }
}
