import 'package:equatable/equatable.dart';

abstract class CollegesEvent extends Equatable {
  CollegesEvent([List props = const []]) : super();

  @override
  List<Object> get props => [];
}


class GetCollegeS extends CollegesEvent {
  @override
  String toString() => 'GetColleges';
}