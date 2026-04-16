import 'package:chat_bot/config/app_config.dart';
import 'package:chat_bot/run_chat_app.dart';

void main () {
  AppConfig appConfig = AppConfig(
      isSentryEnabled: true,
      baseUrl: 'https://api.openai.com/v1/' ,
      appEnvironment:  AppEnvironment.staging);

  runChatApp(appConfig);
}