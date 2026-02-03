import 'package:chat_bot/feature/chat_screen/data/repo_impl/repo_impl.dart';
import 'package:chat_bot/feature/chat_screen/domain/repository/chat_repository.dart';
import 'package:get_it/get_it.dart';

import '../../feature/chat_screen/data/data_source/chat_data_source.dart';
import '../../feature/chat_screen/domain/usecase/chat_usecase.dart';
import '../../feature/chat_screen/presentation/cubit/chat_cubit.dart';
import '../api/api_manager.dart';
import '../api/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // 🔧 Core
  getIt.registerLazySingleton<ApiManager>(
    () => ApiManager(dio: DioFactory.getDio()),
  );

  // 📦 Data Sources
  getIt.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(getIt<ApiManager>()),
  );


  // 📚 Repositories
  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(getIt<ChatRemoteDataSource>()),
  );


  // ✅ Use Cases
  getIt.registerLazySingleton<SendMessageUseCase>(
    () => SendMessageUseCase(getIt<ChatRepository>()),
  );



  // 🧠 Cubits
  getIt.registerFactory<ChatCubit>(() => ChatCubit(getIt<SendMessageUseCase>()));
  // getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt<SignUpUsecase>()));
  //
  // getIt.registerFactory<HomeCubit>(
  //   () => HomeCubit(getIt<HomeUsecase>()),
  // );
  //
  // getIt.registerLazySingleton<SearchCubit>(
  //   () => SearchCubit(getIt<SearchUsecase>()),
  // );



}
