import 'package:equatable/equatable.dart';

/// Custom class for passing errors safely. Used to pass error info from data layer to presentation layer using dartz package. Helps handling errors in first layers.
sealed class Failure extends Equatable {
  const Failure({this.errCode, this.message});

  final String? message;
  final int? errCode;

  @override
  List<Object?> get props => [message, errCode];
}

/// Network related errors such connection and etc.
class NetworkFailure extends Failure {
  const NetworkFailure({super.errCode, super.message});
}

/// Server related errors such an invalid ID.
class ServerFailure extends NetworkFailure {
  const ServerFailure({super.errCode, super.message});
}

/// System related errors.
class LocalFailure extends Failure {
  const LocalFailure({super.errCode, super.message});
}

/// Storage related errors.
class CacheFailure extends LocalFailure {
  const CacheFailure({super.errCode, super.message});
}
