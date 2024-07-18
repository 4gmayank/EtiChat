import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Parent class for all failures in Domain Layer\
/// Parent class for all failures in Domain Layer
abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

/// Remote failure in Domain Layer
class ServerFailure extends Failure {
  final String message;

  ServerFailure({
    required this.message,
  }) {
    debugPrint("Server Failure $message");
  }
}

/// Cache failure in Domain Layer
class CacheFailure extends Failure {
  final String message;

  CacheFailure({required this.message});
}
class Impl extends Failure {
}
