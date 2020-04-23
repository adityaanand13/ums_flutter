import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/models/user_model.dart';

abstract class InstructorState extends Equatable {
  const InstructorState();

  @override
  List<Object> get props => [];
}

class InstructorPresent extends InstructorState{
  final UserModel userModel;

  const InstructorPresent({@required this.userModel});

  @override
  List<Object> get props => [userModel];

  @override
  String toString() => 'Instructor ${userModel.id} \n{ username: ${userModel.username} }\n{name: ${userModel.firstName}';
}

class InstructorAdded extends InstructorState{
  final UserModel userModel;

  const InstructorAdded({@required this.userModel});

  @override
  List<Object> get props => [userModel];

  @override
  String toString() => 'Instructor ${userModel.id} \n{ username: ${userModel.username} }\n{name: ${userModel.firstName}';
}

class InstructorAbsent extends InstructorState{}

class InstructorLoading extends InstructorState{}

class InstructorError extends InstructorState{
  final String error;

  const InstructorError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Instructor Failure { error: $error }';
}