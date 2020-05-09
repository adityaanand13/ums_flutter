import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class BacthBloc extends Bloc<BacthEvent, BacthState> {
  @override
  BacthState get initialState => InitialBacthState();

  @override
  Stream<BacthState> mapEventToState(
    BacthEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
