part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class FetchUserDetailEvent extends LoginEvent{
  @override
  List<Object> get props => [];
}
class LoginUserEvent extends LoginEvent{
  String email;
  String password;

  LoginUserEvent(this.email, this.password);

  @override
  List<Object> get props => [];
}