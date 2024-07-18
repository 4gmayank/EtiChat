import 'package:dartz/dartz.dart';
import 'package:eti_chat/core/error/failures.dart';
import 'package:eti_chat/core/usecse/usecase.dart';
import 'package:eti_chat/feature/domain/repositories/repository.dart';

class LoginUseCase extends UseCase<String, LoginParams> {
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(LoginParams params) async {
    return await _repository.login(params.email, params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams(this.email, this.password);
}
