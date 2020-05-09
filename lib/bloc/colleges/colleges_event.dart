import 'package:equatable/equatable.dart';
import 'package:ums_flutter/models/request/college_request.dart';
import 'package:ums_flutter/models/response/college_response.dart';

abstract class CollegesEvent extends Equatable {
  const CollegesEvent();

  @override
  List<Object> get props => [];

}

//Load College from local storage, if not present then get it from server
class CollegesLoaded extends CollegesEvent {}

//get all the colleges from server (update willingly in order to refresh)
class CollegesUpdated extends CollegesEvent {}

// when new create request is sent
class CollegeCreated extends CollegesEvent {
  final CollegeRequest collegeRequest;

  const CollegeCreated(this.collegeRequest);

  @override
  List<Object> get props => [collegeRequest];

  @override
  String toString() => "CollegeCreated {college: $collegeRequest}";
}

//when a college data is updated, it will be copied to its existing place
class CollegeUpdated extends CollegesEvent {
  final CollegeResponse collegeResponse;

  const CollegeUpdated(this.collegeResponse);

  @override
  List<Object> get props => [collegeResponse];

  @override
  String toString() => "CollegeUpdated {college: $collegeResponse}";
}

//this event will get the extra details of the college from the server, hence lazy loading
class CollegeFetch extends CollegesEvent{
  final CollegeResponse collegeResponse;

  const CollegeFetch(this.collegeResponse);

  @override
  List<Object> get props => [collegeResponse];

  @override
  String toString() => "College Fetched {college: $collegeResponse}";
}

