part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();
}

class RegistrationInitial extends RegistrationState {
  @override
  List<Object> get props => [];
}

class RegistrationLoadingState extends RegistrationState {
  @override
  List<Object> get props => [];
}

class RegistrationErrorState extends RegistrationState {
  final String message;

  RegistrationErrorState(this.message);

  @override
  List<Object> get props => [];
}

class RegistrationLoadedState extends RegistrationState {
  @override
  List<Object> get props => [];
}

class CountryLoadedState extends RegistrationState {
  final List<CountryEntity> countries;

  const CountryLoadedState(this.countries);

  @override
  List<Object> get props => [];
}
