import 'package:dartz/dartz.dart';
import 'package:eti_chat/core/error/exceptions.dart';
import 'package:eti_chat/core/error/failures.dart';
import 'package:eti_chat/feature/data/data_sources/local_datasource.dart';
import 'package:eti_chat/feature/domain/entities/country_entity.dart';
import 'package:eti_chat/feature/domain/entities/message_entity.dart';
import 'package:eti_chat/feature/domain/entities/success_message_entity.dart';
import 'package:eti_chat/feature/domain/entities/user_entity.dart';
import 'package:eti_chat/feature/domain/repositories/repository.dart';

class RepositoryImpl extends Repository {
  final LocalDataSource localDataSource;

// final RemoteDataSource remoteDataSource;
// final NetworkInfo networkInfo;

  RepositoryImpl({
    // required this.networkInfo,
    required this.localDataSource,
    // required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<ChatMessageEntity>>> fetchChatMsg() async {
    return Left(Impl());
  }

  @override
  Future<Either<Failure, UserEntity>> fetchUserDetails() async {
    try {
      final result = await localDataSource.getUserRegistration();
      if (result != null) {
        return Right(result);
      }
      return Left(CacheFailure(message: "no issue"));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<CountryEntity>>> getCountries() async {
    return Left(Impl());
  }

  @override
  Future<Either<Failure, String>> login(String email, String password) async {
    try {
      final UserEntity? data =await  localDataSource.getUserRegistration();
      if(data == null || data.email != email){
        return Left(CacheFailure(message: "signup"));
      }
      if(data.email == email && password != data.password){
        return Left(CacheFailure(message: "Password dont match"));
      }
      return const Right("Login Successfully");
      return Left(CacheFailure(message: "no issue"));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> registerUser(
      {required UserEntity userEntity}) async {
    try {
      localDataSource.saveUserRegistration(userEntity);
      return const Right(true);
      return Left(CacheFailure(message: "no issue"));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> sendChatMsg(ChatMessageEntity params) async {
    return Left(Impl());
  }
}
