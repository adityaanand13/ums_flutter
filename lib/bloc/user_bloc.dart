import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:ums_flutter/event_state/user/user_event.dart';
import 'package:ums_flutter/event_state/user/user_state.dart';
import 'package:ums_flutter/models/user_model.dart';
import 'package:ums_flutter/services/user_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;


  UserBloc({@required this.userService}) : assert(userService != null);

  @override
  UserState get initialState => UserAbsent();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is GetUser) {
      yield UserLoading();
      try {
        bool user = await userService.hasUser();
        if (user){
          UserModel userModel = await userService.getUser();
          yield UserPresent(userModel: userModel);
        }else{
          UserModel userModel = await userService.fetchUser();
          yield UserPresent(userModel: userModel);
        }
      } catch (error) {
        yield UserError(error: error.toString());
      }
    }
    else if (event is GetUser|| event is FetchUser || event is UpdateUser) {
      yield UserLoading();
      try {
        UserModel userModel = await userService.fetchUser();
        userService.persistUser(userModel);
        yield UserPresent(userModel: userModel);
      } catch (error) {
        yield UserError(error: error.toString());
      }
    }
    else if (event is DeleteUser) {
      yield UserLoading();
      userService.deleteUser();
      yield UserAbsent();
    }
    else {
      yield UserLoading();
    }
  }
}
