import 'package:eti_chat/app_routes.dart';
import 'package:eti_chat/core/common_widget/custom_spacer_widget.dart';
import 'package:eti_chat/core/common_widget/validator_text_field.dart';
import 'package:eti_chat/core/conifg/localization.dart';
import 'package:eti_chat/core/conifg/navigation.dart';
import 'package:eti_chat/core/utils/constants.dart';
import 'package:eti_chat/core/utils/custom_extension.dart';
import 'package:eti_chat/feature/presentation/app_language/app_language_bloc.dart';
import 'package:eti_chat/feature/presentation/login_screen/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
//Email, password, login button , signup button,
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordInputController =
      TextEditingController();
  final TextEditingController _emailInputController = TextEditingController();
  String? data;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      _emailInputController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null && data == null) {
      data = ModalRoute.of(context)!.settings.arguments as String;
    }
    return PopScope(
      canPop: false,
      child: SafeArea(
        top: true,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.appColor,
            elevation: 1,
            centerTitle: true,
            title: Text(
              MyLocalizations.of(context).getString("login"),
              style: AppFonts.appBarBoldStyle(fontColor: AppColors.white),
            ),
          ),
          body: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginErrorState) {
                Navigation.back(context);
                if(state.message == "signup"){
                  Navigation.intentWithData(context, AppRoutes.loginScreen, _emailInputController.text);
                }else {
                  widget.showErrorToast(
                      context: context, message: state.message);
                }


              } else if (state is LoginLoadingState) {
                widget.showProgressDialog(context);
              } else if (state is LoginLoadedState) {
                Navigation.back(context);
                Navigation.intentWithClearAllRoutes(context, AppRoutes.homeScreen);
              }
            },
            builder: (context, state) {
              if (state is LoginInitial) {
                context.read<LoginBloc>().add(FetchUserDetailEvent());
              }
              return _getBody();
            },
          ),
        ),
      ),
    );
  }

  Widget _getBody() {
    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      height: MediaQuery.of(context).size.height,
      decoration: AppDecoration.screenDecoration,
      child: _getInputFieldWithButton(),
    );
  }

  _getEnterTextHeading(String str) {
    return Text(
      MyLocalizations.of(context).getString(str),
      textAlign: TextAlign.left,
      style: AppFonts.normalStyle(
        fontWeight: FontWeight.w500,
        fontColor: AppColors.textBlack,
        fontSize: 16.0,
      ),
    );
  }

  _getSignUpHeading() {
    return Text(
      MyLocalizations.of(context).getString('sign_in'),
      style: AppFonts.normalStyle(
        fontWeight: FontWeight.w500,
        fontColor: AppColors.textBlack,
        fontSize: 22.0,
      ),
    );
  }

  _getLoginTextField() {
    return ValidateTextField(
      hintText: MyLocalizations.of(context).getString('enter_email_address'),
      controller: _emailInputController,
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
      validate: (value) => value.isEmpty
          ? MyLocalizations.of(context).getString('enter_your_email')
          : (Constants.emailRegExp.hasMatch(value)
              ? null
              : MyLocalizations.of(context).getString('enter_valid_email')),
    );
  }

  String _validateLogin() {
    String errMsg = "";
    if (_emailInputController.text.isEmpty) {
      errMsg = MyLocalizations.of(context).getString('email_cant_blank');
    }
    return errMsg;
  }

  _getInputFieldWithButton() {
    return Form(
      key: _formKey,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AppLanguageBloc>().emitAppLanguage();
                    },
                    child: Text(MyLocalizations.of(context)
                            .translate('change_language') +
                        context.read<AppLanguageBloc>().language()),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _getEnterTextHeading('email_address'),
                    const CustomSpacerWidget(height: 15.0),
                    _getLoginTextField(),
                    const CustomSpacerWidget(height: 32.0),
                    _getEnterTextHeading("password"),
                    const CustomSpacerWidget(height: 15.0),
                    Center(
                      child: Pinput(
                        length: 4,
                        pinAnimationType: PinAnimationType.slide,
                        controller: _passwordInputController,
                        showCursor: true,
                        onCompleted: (String password) {},
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    const CustomSpacerWidget(height: 38.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<LoginBloc>().add(
                              LoginUserEvent(_emailInputController.text, _passwordInputController.text)
                          );
                          Navigation.intentWithClearAllRoutes(
                              context, AppRoutes.registrationScreen);
                        },
                        child: Text(
                            MyLocalizations.of(context).translate('sign_in')),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
