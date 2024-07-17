import 'package:eti_chat/app_routes.dart';
import 'package:eti_chat/core/common_widget/custom_spacer_widget.dart';
import 'package:eti_chat/core/conifg/localization.dart';
import 'package:eti_chat/core/conifg/navigation.dart';
import 'package:eti_chat/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: locale.translate('name'),
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: locale.translate('mobile'),
                  ),
                ),
                TextField(
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
                  obscureText: true,
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: locale.translate('password'),
                  ),
                ),
                TextField(
                  obscureText: true,
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: locale.translate('confirmPassword'),
                  ),
                ),
                CustomSpacerWidget(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigation.intentWithClearAllRoutes(
                        context, AppRoutes.homeScreen);
                  },
                  child: Text(locale.translate('sign_up')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
