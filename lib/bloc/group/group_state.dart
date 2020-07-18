import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/models/models.dart';

@immutable
abstract class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object> get props => [];
}

class GroupLoadInProgress extends GroupState {}

class GroupLoadSuccess extends GroupState {
  final GroupResponse group;

  GroupLoadSuccess({@required this.group});

  List<Object> get props => [group];

  @override
  String toString() => 'GroupLoadSuccess{group: $group}';
}

class GroupLoadSuccessWithNewStudent extends GroupState {
//  final GroupResponse group;

//  GroupLoadSuccessWithNewStudent({@required this.group});

//  List<Object> get props => [group];

//  @override
//  String toString() => 'GroupLoadSuccess{group: $group}';
}

class GroupLoadError extends GroupState {
  final String error;

  GroupLoadError({@required this.error});

  List<Object> get props => [error];

  @override
  String toString() => 'GroupLoadError{error: $error}';
}