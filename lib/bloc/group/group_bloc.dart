import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:ums_flutter/models/models.dart';
import 'package:ums_flutter/services/group_service.dart';
import './bloc.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupService groupService;

  GroupBloc({@required this.groupService}) : assert(groupService != null);

  @override
  GroupState get initialState => GroupLoadInProgress();

  @override
  Stream<GroupState> mapEventToState(
    GroupEvent event,
  ) async* {
    if(event is GroupCreated){
      yield* _mapGroupCreatedToState(event);
    } else if (event is GroupAddStudent){
      yield* _mapGroupAddStudentToState(event);
    }
  }

  Stream<GroupState> _mapGroupCreatedToState(GroupCreated event) async* {}

  Stream<GroupState> _mapGroupAddStudentToState(GroupAddStudent event) async* {
    yield GroupLoadSuccessWithNewStudent();
  }
}
