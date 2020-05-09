import 'package:equatable/equatable.dart';
import 'package:ums_flutter/models/response/college_response.dart';

abstract class CollegesState extends Equatable {
  const CollegesState();

  @override
  List<Object> get props => [];
}

class CollegesLoadInProgress extends CollegesState {
  @override
  List<Object> get props => [];
}

class CollegesLoadSuccess extends CollegesState {
  final List<CollegeResponse> collegesResponse;

  const CollegesLoadSuccess(this.collegesResponse);

  @override
  List<Object> get props => [collegesResponse];
  @override
  String toString() => "Colleges Load Success {colleges: $collegesResponse}";
}

class CollegesLoadError extends CollegesState {
  final String error;

  const CollegesLoadError(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => "College Load error {error: $error}";
}