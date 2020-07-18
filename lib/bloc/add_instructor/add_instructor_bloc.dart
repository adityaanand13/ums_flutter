import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/models/models.dart';
import 'package:ums_flutter/services/services.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class AddInstructorBloc extends Bloc<AddInstructorEvent, AddInstructorState> {
  final InstructorService instructorService;

  AddInstructorBloc({@required this.instructorService})
      : assert(instructorService != null);

  @override
  AddInstructorState get initialState => InitialAddInstructorState();

  @override
  Stream<AddInstructorState> mapEventToState(
    AddInstructorEvent event,
  ) async* {
    if (event is AddInstructorSubmitted) {
      yield* _mapAddInstructorSubmittedToState(event);
    }
  }

  Stream<AddInstructorState> _mapAddInstructorSubmittedToState(
      AddInstructorSubmitted event) async* {
    try {
      yield AddInstructorLoadInProgress();
      InstructorModel instructor =
          await instructorService.addInstructor(event.instructor);
      yield AddInstructorSuccess(instructor: instructor);
    } catch (_) {
      print("error: ${_.toString()}");
      yield AddInstructorError(error: _);
    }
  }
}
