import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super();
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoggedIn extends AuthenticationEvent {


  @override
  String toString() => 'LoggedIn';

  @override
  List<Object> get props => [];
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';

  @override
  // TODO: implement props
  List<Object> get props => [];
}