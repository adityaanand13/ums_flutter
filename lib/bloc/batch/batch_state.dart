import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/models/response/batch_response.dart';

abstract class BatchState extends Equatable {
  const BatchState();
  @override
  List<Object> get props => [];
}

class BatchLoadInProgress extends BatchState {}

class BatchLoadSuccess extends BatchState{
  final BatchResponse batchResponse;
  final int courseId;

  const BatchLoadSuccess({@required this.batchResponse, @required this.courseId});

  @override
  List<Object> get props => [batchResponse, courseId];

  @override
  String toString() => 'BatchLoadSuccess{batchResponse: $batchResponse, courseId: $courseId}';
}

class BatchLoadError extends BatchState{
  final String error;

  const BatchLoadError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'BatchLoadError{error: $error}';
}
