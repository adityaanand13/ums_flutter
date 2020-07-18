import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:ums_flutter/models/models.dart';
import 'package:ums_flutter/services/services.dart';

import '../bloc.dart';
import './bloc.dart';

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
        final LoginResponse token = await authService.login(
          usernameOrEmail: event.usernameOrEmail,
          password: event.password,
        );
        await authService.persistToken(token.accessToken);
        userService.persistUser(await userService.fetchUser());
        authenticationBloc.add(AuthenticationEvent.LoggedIn);
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
