import 'package:dartz/dartz.dart';
import 'package:eti_chat/core/error/failures.dart';
import 'package:eti_chat/feature/domain/entities/country_entity.dart';
import 'package:eti_chat/feature/domain/entities/message_entity.dart';
import 'package:eti_chat/feature/domain/entities/user_entity.dart';

abstract class Repository {
  /// Sign Up with
  Future<Either<Failure, bool>> registerUser({
    required UserEntity userEntity,
  });

  Future<Either<Failure, List<CountryEntity>>> getCountries();

  Future<Either<Failure, List<ChatMessageEntity>>> fetchChatMsg();

  Future<Either<Failure, UserEntity>> fetchUserDetails();

  Future<Either<Failure, String>> login(String email, String password);

  Future<Either<Failure, String>> sendChatMsg(ChatMessageEntity params);
}
