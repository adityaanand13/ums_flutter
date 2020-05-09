import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  @override
  CourseState get initialState => InitialCourseState();

  @override
  Stream<CourseState> mapEventToState(
    CourseEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
