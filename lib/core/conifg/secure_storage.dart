import 'package:eti_chat/core/utils/constants.dart';
import 'package:eti_chat/feature/domain/entities/user_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class SecureStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Save user registration information
  Future<void> saveUserRegistration(UserEntity user) async {
    final userJson = jsonEncode(user.toJson());
    await _storage.write(key: Constants.user_detail, value: userJson);
  }

  // Retrieve user registration information
  Future<UserEntity?> getUserRegistration() async {
    final userJson = await _storage.read(key: Constants.user_detail);
    if (userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      return UserEntity.fromJson(userMap);
    }
    return null;
  }

  // Delete user registration information
  Future<void> deleteUserRegistration() async {
    await _storage.delete(key: Constants.user_detail);
  }
}
