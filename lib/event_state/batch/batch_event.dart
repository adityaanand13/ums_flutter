import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/models/request/batch_request.dart';

abstract class BatchEvent extends Equatable {
  BatchEvent([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class GetBatch extends BatchEvent {
  final int id;

  GetBatch({@required this.id});
  @override
  @override

  String toString () {
    return 'GetCollege{id: $id}';
  }

}

class UpdateBatch extends BatchEvent {
  final BatchRequest batchRequest;

  UpdateBatch({@required this.batchRequest});

  @override
  String toString () {
    return 'UpdateBatch{batchRequest: $batchRequest}';
  }


}

class CreateBatch extends BatchEvent {
  final int courseId;
  final BatchRequest batchRequest;

  CreateBatch({@required this.courseId, @required this.batchRequest});

  @override
  String toString () {
    return 'CreateBatch {College id: $courseId, batchRequest: $batchRequest}';
  }

}

class DeleteBatch extends BatchEvent {
  final int id;

  DeleteBatch({@required this.id});

  @override
  String toString () {
    return 'DeleteBatch{id: $id}';
  }

}