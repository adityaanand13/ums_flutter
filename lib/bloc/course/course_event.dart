import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/models/request/course_request.dart';
import 'package:ums_flutter/models/response/batch_response.dart';
import 'package:ums_flutter/models/response/course_response.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();

}

//Add Course to the front end
class CourseLoadToUI extends CourseEvent{
  final CourseResponse courseResponse;
  final int collegeId;

  CourseLoadToUI({@required this.courseResponse, @required this.collegeId});

  @override
  String toString() => 'CourseAdd {courseResponse: $courseResponse, collegeId: $collegeId}';

  @override
  List<Object> get props => [courseResponse];
}

//Fetch Data from the internet
class CourseFetch extends CourseEvent {
  final int courseId;
  final int collegeId;

  const CourseFetch({@required this.courseId, @required this.collegeId});

  @override
  String toString () => 'CourseFetch {id: $courseId, collegeId: $collegeId}';

  @override
  List<Object> get props => [courseId, collegeId];

}

//for Editing a course
class CourseUpdateOTA extends CourseEvent {
  final CourseRequest courseRequest;
  final int collegeId;

  const CourseUpdateOTA({@required this.courseRequest, this.collegeId});

  @override
  String toString () => 'CourseUpdateOTA {courseRequest: $courseRequest, in college: $collegeId}';

  @override
  List<Object> get props => [courseRequest, collegeId];
}

//for launching/refreshing new page
class CourseUpdateInternal extends CourseEvent {
  final BatchResponse batchResponse;

  const CourseUpdateInternal({@required this.batchResponse});

  @override
  String toString () => 'CourseUpdateInternal {batchResponse: $batchResponse';

  @override
  List<Object> get props => [batchResponse];
}

//for creating/Editing new college
class CourseCreate extends CourseEvent {
  final int collegeId;
  final CourseRequest courseRequest;

  const CourseCreate({@required this.collegeId, @required this.courseRequest});

  @override
  String toString () => 'CourseCreate {courseRequest: $courseRequest, in college: $collegeId';

  @override
  List<Object> get props => [collegeId, courseRequest];

}

//Delete course on backend
class CourseDelete extends CourseEvent {
  final int courseId;

  const CourseDelete({@required this.courseId});

  @override
  String toString () => 'CourseDelete{id: $courseId}';

  @override
  List<Object> get props => [courseId];
}