import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/models/models.dart';

abstract class CollegesEvent extends Equatable {
  const CollegesEvent();

  @override
  List<Object> get props => [];
}

//Load College from local storage, if not present then get it from server
class CollegesLoaded extends CollegesEvent {}

//get all the colleges from server (update willingly in order to refresh)
class CollegesUpdated extends CollegesEvent {}

// when new create request is sent or PUT request is sent(id = null)
class CollegeCreated extends CollegesEvent {
  final CollegeRequest collegeRequest;

  const CollegeCreated({@required this.collegeRequest});

  @override
  List<Object> get props => [collegeRequest];

  @override
  String toString() => "CollegeCreated {college: $collegeRequest}";
}

//when a college data is updated, it will be copied to its existing place
class CollegeUpdated extends CollegesEvent {
  final CollegeResponse collegeResponse;
  final int collegeIndex;

  const CollegeUpdated(
      {@required this.collegeResponse, this.collegeIndex = -1});

  @override
  List<Object> get props => [collegeResponse];

  @override
  String toString() => "CollegeUpdated {college: $collegeResponse}";
}

class CollegeUpdatedById extends CollegesEvent {
  final int collegeId;
  final CourseResponse courseResponse;

  const CollegeUpdatedById(
      {@required this.collegeId, @required this.courseResponse});

  @override
  List<Object> get props => [collegeId];

  @override
  String toString() => "CollegeUpdatedById {id: $collegeId}";
}

//this event will get the extra details of the college from the server, hence lazy loading
class CollegeFetch extends CollegesEvent {
  final CollegeResponse collegeResponse;

  const CollegeFetch({@required this.collegeResponse});

  @override
  List<Object> get props => [collegeResponse];

  @override
  String toString() => "College Fetched {college: $collegeResponse}";
}

class CollegeUpdatePrincipal extends CollegesEvent {
  final PrincipalAssignResponse principalAssignResponse;

  CollegeUpdatePrincipal({@required this.principalAssignResponse});

  List<Object> get props => [principalAssignResponse];

  @override
  String toString() =>
      'CollegeUpdatePrincipal{Response: $principalAssignResponse}';
}
