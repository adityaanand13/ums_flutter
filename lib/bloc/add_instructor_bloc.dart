import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/event_state/add_instructor/add_instructor_event.dart';
import 'package:ums_flutter/event_state/add_instructor/add_instructor_state.dart';
import 'package:ums_flutter/models/instructor_model.dart';
import 'package:ums_flutter/models/user_model.dart';
import 'package:ums_flutter/services/instructor_service.dart';

class AddInstructorBloc extends Bloc<AddInstructorEvent, AddInstructorState> {
  final InstructorService instructorService;

  AddInstructorBloc({@required this.instructorService})
      : assert(instructorService != null);

  @override
  AddInstructorState get initialState => Uninitialised();

  @override
  Stream<AddInstructorState> mapEventToState(AddInstructorEvent event) async* {
    try{
      if(event is AddInstructor){
        yield AddInstructorLoading();
        InstructorModel newInstructor = await instructorService.addInstructor(event.instructor);
        yield InstructorAdded(instructor: newInstructor);
      }else {
        yield AddInstructorLoading();
      }

    }catch (error){
      yield AddInstructorError(error: error.toString());
    }
  }
}
