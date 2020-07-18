import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/models/response/principal_assign_response.dart';
import 'package:ums_flutter/models/response/usernames_response.dart';

abstract class PrincipalState extends Equatable {
  const PrincipalState();

  @override
  List<Object> get props => [];
}

class PrincipalLoadInProgress extends PrincipalState {}

class InitialPrincipalState extends PrincipalState {}

class PrincipalQueryLoadSuccess extends PrincipalState {
  final UsernamesResponse usernamesResponse;

  const PrincipalQueryLoadSuccess({@required this.usernamesResponse});
  @override
  List<Object> get props => [usernamesResponse];

  @override
  String toString() => 'PrincipalQueryLoadSuccess{usernamesResponse: $usernamesResponse}';
}

class PrincipalAssignSuccess extends PrincipalState{
  final PrincipalAssignResponse principalAssignResponse;

  PrincipalAssignSuccess({@required this.principalAssignResponse});

  List<Object> get props => [principalAssignResponse];

  @override
  String toString() => 'PrincipalAssignSuccess{principalAssignResponse: $principalAssignResponse}';
}

class PrincipalError extends PrincipalState{
  final String error;

  PrincipalError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'PrincipalAssignError{error: $error}';
}


