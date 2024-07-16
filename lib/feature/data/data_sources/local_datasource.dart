

import 'package:eti_chat/core/conifg/shared_pref.dart';

abstract class LocalDataSource{

  String getLocaleLanguage();

  void setLocaleLanguage(String languageCode);

}

class LocalDataSourceImpl extends LocalDataSource {
  final SharedPref sharedPref;

  LocalDataSourceImpl({
    required this.sharedPref,
    // required this.dbProvider,
  });

  @override
  String getLocaleLanguage() {
    return sharedPref.getLocaleLanguage();
  }

  @override
  void setLocaleLanguage(String languageCode) {
    sharedPref.setLocaleLanguage(languageCode);
  }

}