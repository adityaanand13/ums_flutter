import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/models/request/college_request.dart';

abstract class CollegeEvent extends Equatable {
  CollegeEvent([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class GetCollege extends CollegeEvent {
  final int id;

  GetCollege({@required this.id});
  @override
  @override

  String toString () {
    return 'GetCollege{id: $id}';
  }

}

class CloseCollege extends CollegeEvent {}

class UpdateCollege extends CollegeEvent {
  final CollegeRequest collegeRequest;

  UpdateCollege({@required this.collegeRequest});

  @override
  String toString () {
    return 'UpdateCollege{collegeRequest: $collegeRequest}';
  }


}

class CreateCollege extends CollegeEvent {
  final CollegeRequest collegeRequest;

  CreateCollege({@required this.collegeRequest});

  @override
  String toString () {
    return 'CreateCollege{collegeRequest: $collegeRequest}';
  }

}

class DeleteCollege extends CollegeEvent {
  final int id;

  DeleteCollege({@required this.id});

  @override
  String toString () {
    return 'DeleteCollege{id: $id}';
  }

}