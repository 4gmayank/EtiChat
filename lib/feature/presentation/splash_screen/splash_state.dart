part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();
}

class SplashInitial extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashErrorState extends SplashState {
  final String message;


  SplashErrorState(this.message);

  @override
  List<Object> get props => [];
}

class SplashLoadingState extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashLoadedState extends SplashState {
  @override
  List<Object> get props => [];
}
