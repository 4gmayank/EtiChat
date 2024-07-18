import 'package:dartz/dartz.dart';
import 'package:eti_chat/core/error/failures.dart';
import 'package:eti_chat/core/usecse/usecase.dart';
import 'package:eti_chat/feature/domain/entities/country_entity.dart';
import 'package:eti_chat/feature/domain/entities/message_entity.dart';
import 'package:eti_chat/feature/domain/repositories/repository.dart';
import 'package:eti_chat/feature/presentation/home_screen/home_screen.dart';

class FetchChatMsgUseCase extends UseCase<List<ChatMessageEntity>, NoParams> {
  final Repository _repository;

  FetchChatMsgUseCase(this._repository);

  @override
  Future<Either<Failure, List<ChatMessageEntity>>> call(NoParams params) async {
    return await _repository.fetchChatMsg();
  }
}
