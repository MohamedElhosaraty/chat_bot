import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../theming/app_colors.dart';


 class ToastHelper {
  void showErrorToast(BuildContext context, String error) {
    Toastification().show(
      progressBarTheme: const ProgressIndicatorThemeData(
        color: AppColors.darkBlue,
      ),
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 5),
      context: context,
      title: Text(" Error"),
      description: Text(error),
      alignment: Alignment.topCenter,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      icon: const Icon(Icons.error, color: AppColors.darkBlue),
      showIcon: true,
      primaryColor: Colors.red,
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.darkBlue,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: false,
      callbacks: ToastificationCallbacks(
        // ignore: avoid_debugPrint
        onTap: (toastItem) => debugPrint('Toast ${toastItem.id} tapped'),
        onCloseButtonTap: (toastItem) =>
            debugPrint('Toast ${toastItem.id} close button tapped'),
        onAutoCompleteCompleted: (toastItem) =>
            debugPrint('Toast ${toastItem.id} auto complete completed'),
        onDismissed: (toastItem) =>
            debugPrint('Toast ${toastItem.id} dismissed'),
      ),
    );
  }

  void showSuccessToast(BuildContext context, String message) {
    Toastification().show(
      progressBarTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryColor,
      ),
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 5),
      context: context,
      title: Text('success'),
      description: Text(message),
      alignment: Alignment.topCenter,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      icon: const Icon(
        Icons.check,
        color: AppColors.primaryColor,
      ),
      showIcon: true,
      primaryColor: AppColors.primaryColor,
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.darkBlue,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: false,
      callbacks: ToastificationCallbacks(
        onTap: (toastItem) => debugPrint('Toast ${toastItem.id} tapped'),
        onCloseButtonTap: (toastItem) =>
            debugPrint('Toast ${toastItem.id} close button tapped'),
        onAutoCompleteCompleted: (toastItem) =>
            debugPrint('Toast ${toastItem.id} auto complete completed'),
        onDismissed: (toastItem) =>
            debugPrint('Toast ${toastItem.id} dismissed'),
      ),
    );
  }
}
