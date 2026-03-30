enum AppEnvironment {
  development,
  production,
  staging,
}

class AppConfig {
  final String baseUrl;
  final AppEnvironment appEnvironment;
  AppConfig({required this.baseUrl,required this.appEnvironment});
}