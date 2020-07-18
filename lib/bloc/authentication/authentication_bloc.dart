import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/services/services.dart';
import 'package:ums_flutter/utils/utils.dart';
import './bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService authService;

  AuthenticationBloc({@required this.authService})
      : assert(authService != null);

  @override
  AuthenticationState get initialState =>
      AuthenticationState.AuthenticationUninitialized;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    switch (event) {
      case AuthenticationEvent.AppStarted:
        yield* _mapAppStartedToState(event);
        break;
      case AuthenticationEvent.LoggedIn:
        yield AuthenticationState.AuthenticationAuthenticated;
        break;
      case AuthenticationEvent.LoggedOut:
        yield* _mapLoggedOutToState(event);
        break;
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState(
      AuthenticationEvent event) async* {
    try {
      final bool hasToken = await authService.hasToken();
      if (hasToken) {
        final TokenStatus token = await authService.checkToken();
        //todo refactor 401 and error
        switch (token) {
          case TokenStatus.OK:
            yield AuthenticationState.AuthenticationAuthenticated;
            break;
          case TokenStatus.UNAUTHORISED:
            yield AuthenticationState.AuthenticationUnauthenticated;
            break;
          case TokenStatus.ERROR:
            yield AuthenticationState.AuthenticationUnauthenticated;
            break;
        }
      } else {
        yield AuthenticationState.AuthenticationUnauthenticated;
      }
    } catch (_) {
      yield AuthenticationState.AuthenticationError;
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState(
      AuthenticationEvent event) async* {
    try {
      yield AuthenticationState.AuthenticationLoading;
      await authService.logout();
      yield AuthenticationState.AuthenticationUnauthenticated;
    } catch (_) {
      print("error: ${_.toString()}");
      yield AuthenticationState.AuthenticationError;
    }
  }
}
