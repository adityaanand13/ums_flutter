import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/models/request/course_request.dart';

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
    return 'GetCollege{id: $id}';
  }

}

class UpdateCourse extends CourseEvent {
  final CourseRequest courseRequest;

  UpdateCourse({@required this.courseRequest});

  @override
  String toString () {
    return 'UpdateCourse{courseRequest: $courseRequest}';
  }


}

class CreateCourse extends CourseEvent {
  final int collegeId;
  final CourseRequest courseRequest;

  CreateCourse({@required this.collegeId, @required this.courseRequest});

  @override
  String toString () {
    return 'CreateCourse {College id: $collegeId, courseRequest: $courseRequest}';
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