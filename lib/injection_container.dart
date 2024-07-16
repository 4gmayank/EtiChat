import 'package:eti_chat/feature/presentation/app_language/app_language_bloc.dart';
import 'package:eti_chat/feature/presentation/home_screen/home_bloc.dart';
import 'package:eti_chat/feature/presentation/login_screen/login_bloc.dart';
import 'package:eti_chat/feature/presentation/registration_screen/registration_bloc.dart';
import 'package:eti_chat/feature/presentation/splash_screen/splash_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => SplashBloc());
  sl.registerFactory(() => LoginBloc());
  sl.registerFactory(() => RegistrationBloc());
  sl.registerFactory(() => HomeBloc());
  sl.registerFactory(() => AppLanguageBloc(localDataSource: LocalDataSource()));
  //
  //
  //
  // final dio = Dio();
  // // if (kDebugMode) {
  // dio.interceptors.add(LogInterceptor(
  //     request: true,
  //     responseBody: true,
  //     requestBody: true,
  //     error: true,
  //     requestHeader: true,
  //     logPrint: print,
  //     responseHeader: true));
  // // }
}
