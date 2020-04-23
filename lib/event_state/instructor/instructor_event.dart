import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/models/user_model.dart';

abstract class InstructorEvent extends Equatable {
  InstructorEvent([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class GetInstructor extends InstructorEvent {
  final int id;

  GetInstructor(this.id);
  @override
  String toString() => 'GetUser';
}

class AddInstructor extends InstructorEvent {
  final UserModel userModel;

  AddInstructor({@required this.userModel}) : super();

  @override
  String toString() => 'New Instructor : ${userModel.toString()}';
}

class UpdateInstructor extends InstructorEvent {
  @override
  String toString() => 'UpdateUser';
}

class DeleteInstructor extends InstructorEvent {
  @override
  String toString() => 'DeleteUser';
}

