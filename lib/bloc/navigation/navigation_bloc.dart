import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:ums_flutter/bloc/authentication_bloc.dart';
import 'package:ums_flutter/event_state/authentication/authentication_event.dart';
import 'package:ums_flutter/screens/Profile_screen/my_accounts_screen.dart';
import 'package:ums_flutter/screens/college/add_college_View.dart';
import 'package:ums_flutter/screens/college/college_screen.dart';
import 'package:ums_flutter/screens/courses/courses_screen.dart';
import 'package:ums_flutter/screens/login_screen/login_screen.dart';
import 'package:ums_flutter/screens/my_orders_screen.dart';
import 'package:ums_flutter/services/auth_service.dart';
import 'package:ums_flutter/services/user_service.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  MyAccountClickedEvent,
  MyOrdersClickedEvent,
  LogoutClickedEvent,
  AddCollegeView,
  AddCourseEvent
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  final AuthenticationBloc authenticationBloc;
  final UserService userService;
  final AuthService authService;

  NavigationBloc({
    @required this.authenticationBloc,
    @required this.userService,
    @required this.authService,
  }) : assert(authenticationBloc != null);

  @override
  NavigationStates get initialState => MyAccountsScreen(userService: userService,);

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield HomeScreen();
        break;
      case NavigationEvents.MyAccountClickedEvent:
        yield MyAccountsScreen(userService: userService,);
        break;
      case NavigationEvents.MyOrdersClickedEvent:
        yield MyOrdersScreen();
        break;
      case  NavigationEvents.AddCollegeView:
        yield AddCollegeView();
        break;
      case NavigationEvents.AddCourseEvent:
        yield AddCourses();
        break;
      case NavigationEvents.LogoutClickedEvent:
        authenticationBloc.add(LoggedOut());
        yield LoginScreen(userService: userService,authService: authService,);
        break;
    }
  }
}
