import 'package:eti_chat/app_routes.dart';
import 'package:eti_chat/core/conifg/localization.dart';
import 'package:eti_chat/feature/presentation/app_language/app_language_bloc.dart';
import 'package:eti_chat/feature/presentation/app_language/app_language_bloc.dart';
import 'package:eti_chat/feature/presentation/home_screen/home_bloc.dart';
import 'package:eti_chat/feature/presentation/home_screen/home_screen.dart';
import 'package:eti_chat/feature/presentation/login_screen/login_bloc.dart';
import 'package:eti_chat/feature/presentation/login_screen/login_screen.dart';
import 'package:eti_chat/feature/presentation/registration_screen/registration_bloc.dart';
import 'package:eti_chat/feature/presentation/registration_screen/registration_screen.dart';
import 'package:eti_chat/feature/presentation/splash_screen/splash_bloc.dart';
import 'package:eti_chat/feature/presentation/splash_screen/splash_screen.dart';
import 'package:eti_chat/injection_container.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'injection_container.dart' as di;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'Chat Notification', // title
    description: 'This channel is used for important Chat notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  debugPrint("receive");
  // Routes are redirected on HomeScreen...
  // String route = message.data["redirect_to"];
  // String routeDetailId = message.data["id"];
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // TestWidgetsFlutterBinding.ensureInitialized();
  // MIXIN

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppLanguageBloc>(
          create: (context) => sl.get<AppLanguageBloc>(),
        ),
      ],
      child: BlocBuilder<AppLanguageBloc, Locale>(
        builder: (context, state) {
          debugPrint("state  $state");

          return MaterialApp(
            title: 'Chat Buddy',
            locale: state,
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.splash,
            localizationsDelegates: const [
              MyLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('ar', ''),
            ],
            routes: _registerRoutes(),
          );
        },
      ),
    );
  }
}

Map<String, WidgetBuilder> _registerRoutes() {
  return <String, WidgetBuilder>{
    AppRoutes.splash: (context) => BlocProvider<SplashBloc>(
          create: (context) => sl<SplashBloc>(),
          child: const SplashScreen(),
        ),
    AppRoutes.loginScreen: (context) => BlocProvider<LoginBloc>(
          create: (context) => sl<LoginBloc>(),
          child: const LoginScreen(),
        ),
    AppRoutes.homeScreen: (context) => BlocProvider<HomeBloc>(
          create: (context) => sl<HomeBloc>(),
          child: const HomeScreen(),
        ),
    AppRoutes.registrationScreen: (context) => BlocProvider<RegistrationBloc>(
          create: (context) => sl<RegistrationBloc>(),
          child: const RegistrationScreen(),
        ),
  };
}
