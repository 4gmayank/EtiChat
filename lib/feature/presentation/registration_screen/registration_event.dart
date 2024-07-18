part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}

class CountryListEvent extends RegistrationEvent {
  const CountryListEvent();

  @override
  List<Object?> get props => [];
}

class RegisterEvent extends RegistrationEvent {
  final UserEntity userEntity;

  const RegisterEvent(this.userEntity);

  @override
  List<Object?> get props => [];
}
