

import 'package:chat_buddy/feature/presentation/pages/app_language/app_language_bloc.dart';
import 'package:chat_buddy/feature/presentation/pages/login_screen/login_bloc.dart';
import 'package:chat_buddy/feature/presentation/pages/registration_screen/registration_bloc.dart';
import 'package:chat_buddy/feature/presentation/pages/registration_screen/registration_screen.dart';
import 'package:chat_buddy/feature/presentation/pages/splash_screen/splash_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => SplashBloc());
  sl.registerFactory(() => LoginBloc());
  sl.registerFactory(() => RegistrationBloc());
  sl.registerFactory(() => AppLanguageBloc(localDataSource: sl()));



  final dio = Dio();
  // if (kDebugMode) {
  dio.interceptors.add(LogInterceptor(
      request: true,
      responseBody: true,
      requestBody: true,
      error: true,
      requestHeader: true,
      logPrint: print,
      responseHeader: true));
  // }

}