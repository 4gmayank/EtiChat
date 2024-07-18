import 'package:dartz/dartz.dart';
import 'package:eti_chat/core/error/failures.dart';
import 'package:eti_chat/core/usecse/usecase.dart';
import 'package:eti_chat/feature/domain/entities/country_entity.dart';
import 'package:eti_chat/feature/domain/entities/user_entity.dart';
import 'package:eti_chat/feature/domain/repositories/repository.dart';

class RegisterUseCase extends UseCase<bool, UserEntity> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(UserEntity params) async {
    return await _repository.registerUser(userEntity: params);
  }
}
