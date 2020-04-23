import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AddPrincipalState extends Equatable {
  const AddPrincipalState();

  @override
  List<Object> get props => [];
}

class PrincipalAdded extends AddPrincipalError {}

class DefaultState extends AddPrincipalError {}

class PrincipalLoading extends AddPrincipalError {}

class AddPrincipalError extends AddPrincipalState {
  final String error;

  const AddPrincipalError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Add Principal Failure { error: $error }';
}