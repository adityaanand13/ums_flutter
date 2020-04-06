import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/authentication_bloc.dart';
import 'package:ums_flutter/event_state/authentication/authentication_state.dart';
import 'package:ums_flutter/screens/login_screen.dart';
import 'package:ums_flutter/screens/profile.dart';
import 'package:ums_flutter/screens/splash_screen.dart';
import 'package:ums_flutter/screens/widgets/sidebar/sidebar_layout.dart';
import 'package:ums_flutter/services/auth_service.dart';
import 'package:ums_flutter/utils/theme.dart';

class MyApp extends StatelessWidget {
  final AuthService authService;

  MyApp({Key key, @required this.authService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'UMS',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        darkTheme: AppTheme.darkTheme,
//            themeMode: themeState.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationAuthenticated) {
              return SideBarLayout();
            }
            if (state is AuthenticationUnauthenticated) {
              return LoginScreen(authService: authService);
            }
            if (state is AuthenticationLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return SplashPage();
          },
        ),);
  }
}
