import 'dart:async';
import 'dart:developer';

import 'package:eti_chat/app_routes.dart';
import 'package:eti_chat/core/conifg/navigation.dart';
import 'package:eti_chat/core/utils/constants.dart';
import 'package:eti_chat/feature/presentation/splash_screen/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  final int time = 3;

  @override
  void initState() {
    super.initState();
    log("Timer Called", name: "splash");
    _handleNavigation(AppRoutes.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColor,
      body: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              padding: const EdgeInsets.symmetric(horizontal: 26),
              color: AppColors.appColor,
              child: Center(
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 30.0, end: 40.0),
                  duration: Duration(seconds: time),
                  builder: (context, size, child) {
                    return Text(
                      'Careator',
                      style: TextStyle(fontSize: size, color: AppColors.whiteText),
                    );
                  },
                ),
              ),
          );
        },
      ),
    );
  }

  _handleNavigation(final String route) {
    Future.delayed(Duration(seconds: time), () {
      Navigation.intentWithClearAllRoutes(context, route);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
