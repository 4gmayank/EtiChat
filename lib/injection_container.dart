import 'package:eti_chat/core/conifg/shared_pref.dart';
import 'package:eti_chat/feature/data/data_sources/local_datasource.dart';
import 'package:eti_chat/feature/presentation/app_language/app_language_bloc.dart';
import 'package:eti_chat/feature/presentation/home_screen/home_bloc.dart';
import 'package:eti_chat/feature/presentation/login_screen/login_bloc.dart';
import 'package:eti_chat/feature/presentation/registration_screen/registration_bloc.dart';
import 'package:eti_chat/feature/presentation/splash_screen/splash_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => SplashBloc());
  sl.registerFactory(() => LoginBloc());
  sl.registerFactory(() => RegistrationBloc());
  sl.registerFactory(() => HomeBloc());
  sl.registerFactory(() => AppLanguageBloc(localDataSource: sl()));

  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sharedPref: sl()));
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPref>(() => SharedPref(sharedPreferences));


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
