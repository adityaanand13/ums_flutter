import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/models/request/courses_request.dart';

abstract class CourseEvent extends Equatable {
  CourseEvent([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class GetCourse extends CourseEvent {
  final int id;

  GetCourse({@required this.id});
  @override
  @override

  String toString () {
    return 'GetCourses{id: $id}';
  }

}

class CloseCourse extends CourseEvent {}

class UpdateCourse extends CourseEvent {
  final CourseRequest courseRequest;

  UpdateCourse({@required this.courseRequest});

  @override
  String toString () {
    return 'UpdateCourse{courseRequest: $courseRequest}';
  }


}

class CreateCourse extends CourseEvent {}

class CreateCourseButtonPressed extends CourseEvent {
  final CourseRequest courseRequest;

  CreateCourseButtonPressed({@required this.courseRequest});

  @override
  String toString () {
    return 'CreateCourseButtonPressed{courseRequest: $courseRequest}';
  }

}

class DeleteCourse extends CourseEvent {
  final int id;

  DeleteCourse({@required this.id});

  @override
  String toString () {
    return 'DeleteCourse{id: $id}';
  }

}
