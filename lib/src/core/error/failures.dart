import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;

  const Failure({this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({required String message}) : super(message: message);
}

class NoMessageFoundFailure extends Failure {
  const NoMessageFoundFailure({required String message})
      : super(message: message);
}

class CacheFailure extends Failure {}
