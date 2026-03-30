import 'package:chat_bot/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_bot/core/di/dependency_injection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'chat_bot.dart';
import 'core/api/dio_factory.dart';
import 'core/observer/bloc_observer.dart';

void runChatApp(AppConfig appConfig) async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  getIt.registerLazySingleton<AppConfig>(() => appConfig);
  await Future.wait<void>([
    ScreenUtil.ensureScreenSize(),
    setupGetIt(),
    DioFactory.init(),
  ]);
  Bloc.observer = MyBlocObserver();
  runApp(const ChatBot());
}
