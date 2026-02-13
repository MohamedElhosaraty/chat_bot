import 'package:chat_bot/core/routing/routes.dart';
import 'package:chat_bot/feature/chat/ui/page/chat_screen.dart';
import 'package:chat_bot/feature/onboarding/presentation/page/onboarding_screen.dart';
import 'package:flutter/material.dart';

import '../../feature/splash/splash_screen.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
       return MaterialPageRoute(builder: (_) => const SplashScreen());

       case Routes.onBoardingScreen:
       return MaterialPageRoute(builder: (_) => const OnboardingScreen());

       case Routes.chatScreen:
       return MaterialPageRoute(builder: (_) => const ChatScreen());
    }
    return null;
  }
}
