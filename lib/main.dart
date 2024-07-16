import 'package:eti_chat/app_routes.dart';
import 'package:eti_chat/core/conifg/localization.dart';
import 'package:eti_chat/feature/presentation/splash_screen/splash_bloc.dart';
import 'package:eti_chat/feature/presentation/splash_screen/splash_screen.dart';
import 'package:eti_chat/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Buddy',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      localizationsDelegates: [
        MyLocalizationsDelegate(),
        // GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
        // GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      routes: _registerRoutes(),
    );
  }
}


Map<String, WidgetBuilder> _registerRoutes() {
  return <String, WidgetBuilder>{
    AppRoutes.splash: (context) => BlocProvider<SplashBloc>(
      create: (context) => sl<SplashBloc>(),
      child: const SplashScreen(),
    ),
    // AppRoutes.homeScreen: (context) => const HomeScreen(),
    // AppRoutes.registrationScreen: (context) => const RegistrationScreen(),
    // AppRoutes.loginScreen: (context) => const LoginScreen()
  };
}
