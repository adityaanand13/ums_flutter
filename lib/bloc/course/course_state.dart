import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/models/models.dart';
import 'package:ums_flutter/models/response/course_response.dart';

abstract class CourseState extends Equatable {
  const CourseState();
  @override
  List<Object> get props => [];
}

//fixme keeping only courseResponse and collegeId in props

class CourseLoadInProgress extends CourseState {}

class CourseLoadSuccess extends CourseState {
  final CourseResponse courseResponse;
  final int collegeId;

  const CourseLoadSuccess({@required this.courseResponse, @required this.collegeId});

  @override
  List<Object> get props => [courseResponse];

  @override
  String toString() =>  "CourseLoadSuccess:{Course $courseResponse} ";
}

//state needs to be routed to the to courseLoadSuccess from CourseLoadToUI
class CourseEditFetchSuccess extends CourseState{
  final CourseResponse courseResponse;
  final int collegeId;

  const CourseEditFetchSuccess({@required this.courseResponse, @required this.collegeId});

  @override
  List<Object> get props => [courseResponse];

  @override
  String toString() =>  "CourseCreateEditSuccess:{Course $courseResponse} ";
}
//state needs to be routed to the to Colleges Screen with updated data
class CourseCreateSuccess extends CourseState{
  final CollegeResponse collegeResponse;
  final CourseResponse courseResponse;

  CourseCreateSuccess({@required this.collegeResponse, @required this.courseResponse});

  List<Object> get props => [courseResponse];

  @override
  String toString() => 'CourseCreateSuccess{collegeResponse: $collegeResponse, courseResponse: $courseResponse}';
}

class CourseLoadError extends CourseState {
  final String error;

  const CourseLoadError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CourseLoadError{error: $error}';
}