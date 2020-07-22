import 'dart:async';
import 'package:bloc/bloc.dart';
import '../bloc.dart';

class SectionBloc extends Bloc<SectionEvent, SectionState> {
  @override
  SectionState get initialState => InitialSectionState();

  @override
  Stream<SectionState> mapEventToState(
    SectionEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
