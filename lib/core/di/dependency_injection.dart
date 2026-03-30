import 'package:chat_bot/feature/chat/data/repo/gemini_chat_repo_impl.dart';
import 'package:chat_bot/feature/chat/domain/chat_repo.dart';
import 'package:get_it/get_it.dart';

import '../../config/app_config.dart';
import '../../feature/chat/data/service/gemini_chat_service.dart';
import '../../feature/chat/ui/cubit/chat_cubit.dart';
import '../api/api_manager.dart';
import '../api/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // 🔧 Core
  getIt.registerLazySingleton<ApiManager>(
    () => ApiManager(dio: DioFactory.getDio(), appConfig: getIt<AppConfig>()),
  );

  // 📦 Data Sources
  getIt.registerLazySingleton<GeminiChatService>(
    () => GeminiChatService(apiManager: getIt<ApiManager>()),
  );

  // 📚 Repositories

  getIt.registerLazySingleton<ChatRepo>(
    () => GeminiChatRepoImpl(getIt<GeminiChatService>()),
  );

  // 🧠 Cubits
  getIt.registerFactory<ChatCubit>(() => ChatCubit(getIt<ChatRepo>()));
}
