import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/models/response/college_s_response.dart';

abstract class CollegesState extends Equatable {
  const CollegesState();

  @override
  List<Object> get props => [];
}

class CollegesAbsent extends CollegesState{}

class CollegesLoading extends CollegesState{}

class CollegesPresent extends CollegesState{
  final CollegesResponse collegesResponse;

  CollegesPresent({@required this.collegesResponse});

  @override
  String toString () {
    return 'CollegesPresent{collegesResponse: $collegesResponse}';
  }

  @override
  List<Object> get props => [collegesResponse];
}

class CollegesError extends CollegesState {
  final String error;

  const CollegesError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CollegeFailure { error: $error }';
}
