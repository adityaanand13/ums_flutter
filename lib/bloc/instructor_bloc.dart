import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:ums_flutter/event_state/instructor/Instructor_event.dart';
import 'package:ums_flutter/event_state/instructor/instructor_state.dart';
import 'package:ums_flutter/models/user_model.dart';
import 'package:ums_flutter/services/instructor_service.dart';

class InstructorBloc extends Bloc<InstructorEvent, InstructorState> {
  final InstructorService instructorService;

  InstructorBloc({@required this.instructorService})
      : assert(instructorService != null);

  @override
  InstructorState get initialState => InstructorAbsent();

  @override
  Stream<InstructorState> mapEventToState(InstructorEvent event) async* {
    try {
      if (event is GetInstructor) {
        yield InstructorLoading();
        UserModel userModel = await instructorService.getInstructor();
        yield InstructorPresent(userModel: userModel);
      }
      //todo implement updating details and deleting details
//    else if (event is UpdateInstructor) {
//
//    }
//    else if (event is DeleteInstructor) {
//      yield InstructorLoading();
//      instructorService.deleteUser();
//      yield UserAbsent();
//    }
      else {
        yield InstructorLoading();
      }
    } catch (error) {
      yield InstructorError(error: error.toString());
    }
  }
}
