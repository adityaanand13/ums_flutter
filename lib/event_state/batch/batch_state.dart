import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/models/response/batch_response.dart';
import 'package:ums_flutter/models/response/course_response.dart';

abstract class BatchState extends Equatable {
  const BatchState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class BatchAbsent extends BatchState {}

class BatchLoading extends BatchState {}

class BatchAdded extends BatchState {
  final BatchResponse batchResponse;

  BatchAdded({@required this.batchResponse});

  @override
  String toString() {
    return 'CollegeAdded{collegeResponse: $batchResponse}';
  }

  @override
  List<Object> get props => [batchResponse];
}

class BatchCreated extends BatchState {
  final CourseResponse courseResponse;

  BatchCreated({@required this.courseResponse});

  @override
  String toString() {
    return 'Batch Created {CourseResponse: $courseResponse}';
  }
}

class BatchError extends BatchState {
  final String error;

  const BatchError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Batch Failure { error: $error }';
}
