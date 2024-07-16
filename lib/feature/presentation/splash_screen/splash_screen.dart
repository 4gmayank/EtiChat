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

  @override
  void initState() {
    super.initState();
    log("Timer Called", name: "splash");
    _handleNavigation(AppRoutes.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 26),
            color: AppColors.white,
            child: const Center(
              child: Text("Careator"),
            ),
          );
        },
      ),
    );
  }

  _handleNavigation(final String route) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigation.intentWithClearAllRoutes(context, route);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
