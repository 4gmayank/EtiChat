import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eti_chat/core/error/failures.dart';
import 'package:eti_chat/core/usecse/usecase.dart';
import 'package:eti_chat/feature/domain/entities/country_entity.dart';
import 'package:eti_chat/feature/domain/entities/user_entity.dart';
import 'package:eti_chat/feature/domain/use_cases/country_use_case.dart';
import 'package:eti_chat/feature/domain/use_cases/register_use_case.dart';

part 'registration_event.dart';

part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegisterUseCase _registerUserCase;
  final CountryUseCase _countryUseCase;

  RegistrationBloc({
    required final RegisterUseCase registerUserCase,
    required final CountryUseCase countryUseCase,
  })  : _registerUserCase = registerUserCase,
        _countryUseCase = countryUseCase,
        super(RegistrationInitial()) {
    on<RegistrationEvent>((event, emit) async {
      if (event is RegisterEvent) {
        emit.call(RegistrationLoadingState());
        final data = await _registerUserCase.call(
          event.userEntity,
        );
        data.fold((failure) async {
          if (failure is CacheFailure) {
            emit.call(RegistrationErrorState(failure.message));
          } else if (failure is ServerFailure) {
            emit.call(RegistrationErrorState(failure.message));
          }
        }, (loadedDataEntity) async {
          emit.call(RegistrationLoadedState());
        });
      } else if (event is CountryListEvent) {
        emit.call(RegistrationLoadingState());
        final data = await _countryUseCase.call(NoParams());
        data.fold((failure) async {
          if (failure is CacheFailure) {
            emit.call(RegistrationErrorState(failure.message));
          } else if (failure is ServerFailure) {
            emit.call(RegistrationErrorState(failure.message));
          }
        }, (loadedDataEntity) async {
          emit.call(CountryLoadedState(loadedDataEntity));
        });
      }
    });
  }
}
