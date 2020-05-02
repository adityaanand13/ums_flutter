import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ums_flutter/models/instructor_model.dart';
import 'package:ums_flutter/models/user_model.dart';

abstract class AddInstructorState extends Equatable {
  const AddInstructorState() : super();

  List<Object> get props => [];
}

class Uninitialised extends AddInstructorState {}

class AddInstructorLoading extends AddInstructorState{}

class InstructorAdded extends AddInstructorState{
  final InstructorModel instructor;

  const InstructorAdded({@required this.instructor});
}

class AddInstructorError extends AddInstructorState{
  final String error;

  const AddInstructorError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Add Instructor Failure { error: $error }';
}
