import 'package:dartz/dartz.dart';
import 'package:eti_chat/core/error/failures.dart';
import 'package:eti_chat/core/usecse/usecase.dart';
import 'package:eti_chat/feature/domain/entities/country_entity.dart';
import 'package:eti_chat/feature/domain/repositories/repository.dart';

class CountryUseCase extends UseCase<List<CountryEntity>, NoParams> {
  final Repository _repository;

  CountryUseCase(this._repository);

  @override
  Future<Either<Failure, List<CountryEntity>>> call(NoParams params) async {
    return await _repository.getCountries();
  }
}
