import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:ums_flutter/models/models.dart';

abstract class AddInstructorState extends Equatable {
  const AddInstructorState();

  @override
  List<Object> get props => [];
}

class InitialAddInstructorState extends AddInstructorState {}

class AddInstructorLoadInProgress extends AddInstructorState{}

class AddInstructorSuccess extends AddInstructorState{
  final InstructorModel instructor;

  const AddInstructorSuccess({@required this.instructor});
}

class AddInstructorError extends AddInstructorState{
  final String error;

  const AddInstructorError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Add Instructor Failure { error: $error }';
}
