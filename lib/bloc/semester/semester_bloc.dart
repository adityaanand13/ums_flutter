import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/services/semester_service.dart';
import '../bloc.dart';

class SemesterBloc extends Bloc<SemesterEvent, SemesterState> {
  final SemesterService semesterService;

  SemesterBloc({@required this.semesterService});

  @override
  SemesterState get initialState => InitialSemesterState();

  @override
  Stream<SemesterState> mapEventToState(
    SemesterEvent event,
  ) async* {
    if (event is SemesterActivate) {
      yield* _mapSemesterActivateToState(event);
    }
  }

  Stream<SemesterState> _mapSemesterActivateToState(SemesterActivate event) async* {
    try {
      yield SemesterLoadInProgress();
      yield SemesterLoadSuccess(
          semesterResponse: await semesterService.activate(event.id),
          batchId: event.batchId);
    } catch (_) {
      print("error: ${_.toString()}");
      yield SemesterLoadError(error: _);
    }
  }
}
