import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:ums_flutter/event_state/authentication/authentication_event.dart';
import 'package:ums_flutter/event_state/authentication/authentication_state.dart';
import 'package:ums_flutter/services/auth_service.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService authService;

  AuthenticationBloc({@required this.authService})
      : assert(authService != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      final bool hasToken = await authService.hasToken();
      if (hasToken) {
        final bool isTokenValid = await authService.checkToken();
        if(isTokenValid){
          yield AuthenticationAuthenticated();
        }else{
          yield AuthenticationUnauthenticated();
        }
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await authService.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
