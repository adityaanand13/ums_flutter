import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/services/college_service.dart';
import 'package:ums_flutter/services/instructor_service.dart';
import 'package:meta/meta.dart';
import 'bloc.dart';

class PrincipalBloc extends Bloc<PrincipalEvent, PrincipalState> {
  final InstructorService instructorService;
  final CollegeService collegeService;

  PrincipalBloc(
      {@required this.collegeService, @required this.instructorService})
      : assert(instructorService != null),
        assert(collegeService != null);

  @override
  PrincipalState get initialState => InitialPrincipalState();

  @override
  Stream<PrincipalState> mapEventToState(
    PrincipalEvent event,
  ) async* {
    if (event is PrincipalSearchQuery) {
      yield* _mapPrincipalSearchQueryToState(event);
    } else if (event is AssignNewPrincipal) {
      yield* _mapAssignNewPrincipalToState(event);
    }
  }

  Stream<PrincipalState> _mapPrincipalSearchQueryToState(
      PrincipalSearchQuery event) async* {
    try {
      yield PrincipalLoadInProgress();
      yield PrincipalQueryLoadSuccess(
          usernamesResponse:
              await instructorService.searchInstructor(event.key));
    } catch (_) {
      print("error: ${_.toString()}");
      yield PrincipalError(error: _);
    }
  }

  Stream<PrincipalState> _mapAssignNewPrincipalToState(
      AssignNewPrincipal event) async* {
    try {
      yield PrincipalLoadInProgress();
      //todo update college bloc then .add event in principal bloc from college bloc
      print("_mapAssignNewPrincipalToState");
      var response = await collegeService.addPrincipal(
          collegeID: event.collegeId, instructorId: event.instructorId);
      print(response);
      yield PrincipalAssignSuccess(
          principalAssignResponse: response);
    } catch (_) {
      print("error: ${_.toString()}");
      yield PrincipalError(error: _);
    }
  }
}
