import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/models/request/batch_request.dart';
import 'package:ums_flutter/models/response/batch_response.dart';
import 'package:ums_flutter/models/response/response.dart';

abstract class BatchEvent extends Equatable {
  const BatchEvent();
}

class BatchAdd extends BatchEvent{
  final BatchResponse batchResponse;
  final int courseId;

  const BatchAdd({@required this.batchResponse, @required this.courseId});

  @override
  String toString() => 'BatchAdd {batchResponse: $batchResponse, courseId: $courseId}';

  @override
  List<Object> get props => [batchResponse, courseId];
}

class BatchFetch extends BatchEvent{
  final int batchId;
  final int courseId;

  const BatchFetch({@required this.batchId, @required this.courseId});

  @override
  String toString () => 'BatchFetch {id: $batchId, courseId: $courseId}';

  @override
  List<Object> get props => [batchId, courseId];
}

class BatchUpdateOTA extends BatchEvent{
  final BatchRequest batchRequest;
  final int courseId;

  const BatchUpdateOTA({@required this.batchRequest, @required this.courseId});

  @override
  String toString () => 'BatchUpdateOTA {batchRequest: $batchRequest, courseId: $courseId}';

  @override
  List<Object> get props => [batchRequest, courseId];
}

class BatchUpdateInternal extends BatchEvent{
  final SemesterResponse semesterResponse;

  const BatchUpdateInternal({@required this.semesterResponse});


  @override
  String toString() => 'BatchUpdateInternal {semesterResponse: $semesterResponse}';

  @override
  List<Object> get props => [semesterResponse];


}

class BatchCreate extends BatchEvent {
  final int courseId;
  final BatchRequest batchRequest;

  BatchCreate({@required this.courseId, @required this.batchRequest});

  @override
  List<Object> get props => [courseId, batchRequest];

  @override
  String toString() => 'BatchCreate{courseId: $courseId, batchRequest: $batchRequest}';
}

class BatchDelete extends BatchEvent {
  final int batchId;

  const BatchDelete({@required this.batchId});


  @override
  String toString() => 'BatchDelete{batchInt: $batchId}';

  @override
  List<Object> get props => [batchId];

}