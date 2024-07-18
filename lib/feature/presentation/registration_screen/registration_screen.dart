import 'package:eti_chat/app_routes.dart';
import 'package:eti_chat/core/common_widget/custom_spacer_widget.dart';
import 'package:eti_chat/core/conifg/localization.dart';
import 'package:eti_chat/core/conifg/navigation.dart';
import 'package:eti_chat/core/utils/constants.dart';
import 'package:eti_chat/core/utils/custom_extension.dart';
import 'package:eti_chat/feature/domain/entities/user_entity.dart';
import 'package:eti_chat/feature/presentation/registration_screen/registration_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String _fcmToken = "";

  @override
  void initState() {
    super.initState();
    _fcm.getToken().then((fcmToken) {
      setState(() {
        _fcmToken = fcmToken ?? "";
        debugPrint("FCM token = $_fcmToken");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.of(context);

    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appColor,
          elevation: 1,
          centerTitle: true,
          title: Text(
            MyLocalizations.of(context).getString("registration"),
            style: AppFonts.appBarBoldStyle(fontColor: AppColors.white),
          ),
        ),
        body: BlocConsumer<RegistrationBloc, RegistrationState>(
          listener: (context, state) {
            if (state is RegistrationErrorState) {
              Navigation.back(context);
              widget.showErrorToast(context: context, message: state.message);
            } else if (state is RegistrationLoadingState) {
              widget.showProgressDialog(context);
            } else if (state is RegistrationLoadedState) {
              Navigation.back(context);
              Navigation.intentWithClearAllRoutes(
                  context, AppRoutes.homeScreen);
            }
          },
          builder: (context, state) {
            if (state is RegistrationInitial) {
              context.read<RegistrationBloc>().add(
                    const CountryListEvent(),
                  );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: locale.translate('name'),
                      ),
                    ),
                    TextField(
                      controller: numberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: locale.translate('mobile'),
                      ),
                    ),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: locale.translate('email'),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: locale.translate('country'),
                      ),
                    ),
                    const CustomSpacerWidget(
                      height: 20,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: locale.translate('password'),
                      ),
                    ),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: locale.translate('confirmPassword'),
                      ),
                    ),
                    const CustomSpacerWidget(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        context.read<RegistrationBloc>().add(
                              RegisterEvent(UserEntity(
                                  country: "",
                                  email: emailController.text,
                                  mobile: numberController.text,
                                  name: nameController.text,
                                  password: passwordController.text,
                                  token: _fcmToken,
                                  session: true)),
                            );
                        Navigation.intentWithClearAllRoutes(
                            context, AppRoutes.homeScreen);
                      },
                      child: Text(locale.translate('sign_up')),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
