import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:ums_flutter/models/models.dart';

abstract class AddInstructorEvent extends Equatable {
  const AddInstructorEvent();

  @override
  List<Object> get props => [];
}

class AddInstructorSubmitted extends AddInstructorEvent {
  final InstructorModel instructor;

  const AddInstructorSubmitted({@required this.instructor});

  @override
  List<Object> get props => [instructor];

  @override
  String toString() => 'AddInstructor{instructor: $instructor}';
}