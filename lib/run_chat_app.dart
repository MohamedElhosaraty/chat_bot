import 'package:chat_bot/config/app_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_bot/core/di/dependency_injection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
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

  if (appConfig.isSentryEnabled) {
    final isRelease = const bool.fromEnvironment('dart.vm.product');

    await SentryFlutter.init(
          (options) {
            options.dsn = "https://f84f022d841dcc5d2bbddeb62587591e@o4511228995305472.ingest.us.sentry.io/4511229001400320";
            options.sendDefaultPii = true;
            options.tracesSampleRate = isRelease ? 0.1 : 1.0;
            options.environment = appConfig.appEnvironment.name;
            options.debug = kDebugMode && !isRelease;
      },
      appRunner: () {
        FlutterError.onError = (FlutterErrorDetails details) {
          Sentry.captureException(
            details.exception,
            stackTrace: details.stack,
            hint: Hint.withMap({
              'context': details.context.toString(),
            }),
          );
        };

        runApp(SentryWidget(child: const ChatBot()));
      }
    );
  } else {
    runApp(const ChatBot());
  }
}