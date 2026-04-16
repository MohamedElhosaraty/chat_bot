enum AppEnvironment {
  development,
  production,
  staging,
}

class AppConfig {
  final bool isSentryEnabled;
  final String baseUrl;
  final AppEnvironment appEnvironment;
  AppConfig({required this.baseUrl,required this.appEnvironment, required this.isSentryEnabled});
}