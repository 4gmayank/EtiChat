import 'package:eti_chat/core/conifg/secure_storage.dart';
import 'package:eti_chat/core/conifg/shared_pref.dart';
import 'package:eti_chat/feature/domain/entities/user_entity.dart';

abstract class LocalDataSource {
  String getLocaleLanguage();

  void setLocaleLanguage(String languageCode);

  void saveUserRegistration(UserEntity user);

  Future<UserEntity?> getUserRegistration();
}

class LocalDataSourceImpl extends LocalDataSource {
  final SharedPref sharedPref;
  final SecureStorage secureStorage;

  LocalDataSourceImpl({
    required this.sharedPref,
    required this.secureStorage,
  });

  @override
  String getLocaleLanguage() {
    return sharedPref.getLocaleLanguage();
  }

  @override
  void setLocaleLanguage(String languageCode) {
    sharedPref.setLocaleLanguage(languageCode);
  }

  @override
  Future<UserEntity?> getUserRegistration() {
    return secureStorage.getUserRegistration();
  }

  @override
  void saveUserRegistration(UserEntity user) {
    secureStorage.saveUserRegistration(user);
  }
}
