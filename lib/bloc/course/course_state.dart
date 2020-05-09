import 'package:equatable/equatable.dart';

abstract class CourseState extends Equatable {
  const CourseState();
}

class InitialCourseState extends CourseState {
  @override
  List<Object> get props => [];
}
