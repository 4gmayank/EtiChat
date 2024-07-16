import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const String fcmTokenSentToServer = "fcm_token_passed_to_server";
  static const String fcmToken = "fcm_token";
  static const String languageCode = "languageCode";
  final SharedPreferences _pref;

  SharedPref(this._pref);

  /// Get Language Code
  String getLocaleLanguage() {
    log(_pref.getString(SharedPref.languageCode).toString(), name: "langSP");
    return _pref.getString(SharedPref.languageCode) ?? "en";
  }

  /// Set Language Code
  void setLocaleLanguage(String languageCode) {
    _pref.setString(SharedPref.languageCode, languageCode);
  }
}
