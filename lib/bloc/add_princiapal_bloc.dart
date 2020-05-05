import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/event_state/add_principal/add_principal_event.dart';
import 'package:ums_flutter/event_state/add_principal/add_principal_state.dart';
import 'package:ums_flutter/services/college_service.dart';

class AddPrincipalBloc extends Bloc<AddPrincipalEvent, AddPrincipalState> {
  final CollegeService collegeService;

  AddPrincipalBloc({this.collegeService}) : assert(collegeService != null);

  @override
  get initialState => DefaultState();

  @override
  Stream<AddPrincipalState> mapEventToState(event) async* {
    try {
      if (event is AddButtonPressed) {
        yield PrincipalLoading();
        await collegeService.addPrincipal(
          collegeID: event.collegeId,
          username: event.username,
        );
        yield PrincipalAdded();
      }
    } catch (error) {
      yield AddPrincipalError(error: error);
    }
  }
}
