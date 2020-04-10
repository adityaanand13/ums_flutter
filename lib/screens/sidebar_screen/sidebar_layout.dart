import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/authentication_bloc.dart';
import 'package:ums_flutter/bloc/navigation_bloc.dart';
import 'package:ums_flutter/bloc/user_bloc.dart';
import 'package:ums_flutter/services/auth_service.dart';
import 'package:ums_flutter/services/user_service.dart';

import 'sidebar.dart';

class SideBarLayout extends StatelessWidget {
  final AuthService authService;
  final UserService userService;

  SideBarLayout(
      {Key key, @required this.authService, @required this.userService})
      : assert(authService != null),
        assert(userService != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<NavigationBloc>(
              create: (context) => NavigationBloc(
                  userService: userService,
                  authService: authService,
                  authenticationBloc:
                      BlocProvider.of<AuthenticationBloc>(context))),
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(
              userService: userService,
            ),
          ),
        ],
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc, NavigationStates>(
              builder: (context, navigationState) {
                return navigationState as Widget;
              },
            ),
            SideBar(
              userService: userService,
            ),
          ],
        ),
      ),
    );

  }
}
