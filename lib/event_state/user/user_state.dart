import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/models/user_model.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserPresent extends UserState{
  final UserModel userModel;

  const UserPresent({@required this.userModel});
}

class UserAbsent extends UserState{}

class UserLoading extends UserState{}

class UserError extends UserState{
  final String error;

  const UserError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}