import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String usernameOrEmail;
  final String password;

  const LoginButtonPressed({
    @required this.usernameOrEmail,
    @required this.password,
  });

  @override
  List<Object> get props => [usernameOrEmail, password];

  @override
  String toString() =>
      'LoginButtonPressed { username: $usernameOrEmail, password: $password }';
}