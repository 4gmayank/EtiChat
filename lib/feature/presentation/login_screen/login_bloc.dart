import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eti_chat/core/error/failures.dart';
import 'package:eti_chat/core/usecse/usecase.dart';
import 'package:eti_chat/feature/domain/use_cases/fetch_user_details_use_case.dart';
import 'package:eti_chat/feature/domain/use_cases/login_use_case.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final FetchUserDetailsUseCase _fetchUserDetailsUseCase;

  LoginBloc({
    required final LoginUseCase loginUseCase,
    required final FetchUserDetailsUseCase fetchUserDetailsUseCase,
  })  : _loginUseCase = loginUseCase,
        _fetchUserDetailsUseCase = fetchUserDetailsUseCase,
        super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginUserEvent) {
        emit.call(LoginLoadingState());
        final data = await _loginUseCase.call(
          LoginParams(event.email, event.password),
        );
        data.fold((failure) async {
          if (failure is CacheFailure) {
            emit.call(LoginErrorState(failure.message));
          } else if (failure is ServerFailure) {
            emit.call(LoginErrorState(failure.message));
          }
        }, (loadedDataEntity) async {
          emit.call(LoginLoadedState());
        });
      } else if (event is FetchUserDetailEvent) {
        emit.call(LoginLoadingState());
        final data = await _fetchUserDetailsUseCase.call(NoParams());
        data.fold((failure) async {
          if (failure is CacheFailure) {
            emit.call(LoginErrorState(failure.message));
          } else if (failure is ServerFailure) {
            emit.call(LoginErrorState(failure.message));
          }
        }, (loadedDataEntity) async {
          emit.call(LoginLoadedState());
        });
      }
    });
  }
}
