import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/models/models.dart';

abstract class SemesterState extends Equatable {
  const SemesterState();
  @override
  List<Object> get props => [];
}

class InitialSemesterState extends SemesterState {
  @override
  List<Object> get props => [];
}

class SemesterLoadInProgress extends SemesterState {}

class SemesterLoadSuccess extends SemesterState{
  final SemesterResponse semesterResponse;
  final int batchId;

  const SemesterLoadSuccess({@required this.semesterResponse, @required this.batchId});

  @override
  List<Object> get props => [semesterResponse, batchId];

  @override
  String toString() => 'SemesterLoadSuccess{semesterResponse: $semesterResponse, batchId: $batchId}';
}

class SemesterLoadError extends SemesterState{
  final String error;

  const SemesterLoadError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SemesterLoadError{error: $error}';
}