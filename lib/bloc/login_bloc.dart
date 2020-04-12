import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:ums_flutter/event_state/authentication/authentication_event.dart';
import 'package:ums_flutter/event_state/login/login_event.dart';
import 'package:ums_flutter/event_state/login/login_state.dart';
import 'package:ums_flutter/services/auth_service.dart';
import 'package:ums_flutter/services/user_service.dart';

import 'authentication_bloc.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService authService;
  final AuthenticationBloc authenticationBloc;
  final UserService userService;
  //todo finalise
  LoginBloc({
    @required this.authService,
    @required this.authenticationBloc,
    @required this.userService,
  })  : assert(authService != null),
        assert(userService != null),
        assert(authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        final token = await authService.login(
          usernameOrEmail: event.usernameOrEmail,
          password: event.password,
        );
        userService.deleteUser();
        userService.persistUser(await userService.fetchUser());
        authenticationBloc.add(LoggedIn(token: token.accessToken));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}