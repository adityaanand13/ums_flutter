import 'package:equatable/equatable.dart';

abstract class SectionState extends Equatable {
  const SectionState();
}

class InitialSectionState extends SectionState {
  @override
  List<Object> get props => [];
}
