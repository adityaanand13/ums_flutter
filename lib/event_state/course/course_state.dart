import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/models/response/college_response.dart';
import 'package:ums_flutter/models/response/course_response.dart';

abstract class CourseState extends Equatable {
  const CourseState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class CourseAbsent extends CourseState {}

class CourseLoading extends CourseState {}

class CourseAdded extends CourseState {
  final CourseResponse courseResponse;

  CourseAdded({@required this.courseResponse});

  @override
  String toString() {
    return 'CollegeAdded{collegeResponse: $courseResponse}';
  }

  @override
  List<Object> get props => [courseResponse];
}

class CourseCreated extends CourseState {
  final CollegeResponse collegeResponse;

  CourseCreated({@required this.collegeResponse});

  @override
  String toString() {
    return 'AddCollege{collegeResponse: $collegeResponse}';
  }
}

class CourseError extends CourseState {
  final String error;

  const CourseError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CollegeFailure { error: $error }';
}
