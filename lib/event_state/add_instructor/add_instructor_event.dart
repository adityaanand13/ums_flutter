import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:ums_flutter/models/instructor_model.dart';

abstract class AddInstructorEvent extends Equatable {
  const AddInstructorEvent() : super();

  @override
  List<Object> get props => [];

}

class AddInstructor extends AddInstructorEvent {
  final InstructorModel instructor;

  const AddInstructor({@required this.instructor});
}