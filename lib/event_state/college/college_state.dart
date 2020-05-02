import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/models/response/college_response.dart';
abstract class CollegeState extends Equatable {
  const CollegeState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class CollegeAbsent extends CollegeState{}

class CollegeLoading extends CollegeState{}

class CollegeAdded extends CollegeState{
  final CollegeResponse collegeResponse;

  CollegeAdded({@required this.collegeResponse});

  @override
  String toString () {
    return 'CollegeAdded{collegeResponse: $collegeResponse}';
  }

  @override
  List<Object> get props => [collegeResponse];

}

class EditCollege extends CollegeState{
  final CollegeResponse collegeResponse;

  EditCollege({@required this.collegeResponse});

  @override
  String toString () {
    return 'EditCollege{collegeResponse: $collegeResponse}';
  }

  @override
  List<Object> get props => [collegeResponse];

}

class AddCollege extends CollegeState{
  final CollegeResponse collegeResponse;

  AddCollege({@required this.collegeResponse});

  @override
  String toString () {
    return 'AddCollege{collegeResponse: $collegeResponse}';
  }
}

class CollegeError extends CollegeState {
  final String error;

  const CollegeError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CollegeFailure { error: $error }';
}
