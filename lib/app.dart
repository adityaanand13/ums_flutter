import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/add_instructor_bloc.dart';
import 'package:ums_flutter/bloc/add_princiapal_bloc.dart';
import 'package:ums_flutter/bloc/authentication_bloc.dart';
import 'package:ums_flutter/bloc/colleges/bloc.dart';
import 'package:ums_flutter/bloc/course_bloc.dart';
import 'package:ums_flutter/event_state/authentication/authentication_state.dart';
import 'package:ums_flutter/screens/Profile_screen/my_accounts_screen.dart';
import 'package:ums_flutter/screens/college/colleges_screen.dart';
import 'package:ums_flutter/screens/home.dart';
import 'package:ums_flutter/screens/login_screen/login_screen.dart';
import 'package:ums_flutter/screens/splash_screen.dart';
import 'package:ums_flutter/screens/college/add_college_screen.dart';
import 'package:ums_flutter/services/auth_service.dart';
import 'package:ums_flutter/services/batch_service.dart';
import 'package:ums_flutter/services/course_service.dart';
import 'package:ums_flutter/services/instructor_service.dart';
import 'package:ums_flutter/services/user_service.dart';
import 'package:ums_flutter/utils/theme.dart';
import 'package:ums_flutter/components/drawer/Side_drawer.dart';

import 'bloc/batch_bloc.dart';
import 'bloc/college_bloc.dart';
import 'bloc/user_bloc.dart';
import 'services/college_service.dart';

class MyApp extends StatelessWidget {
  final AuthService authService;
  final UserService userService;

  final CollegeService _collegeService = CollegeService();
  final InstructorService _instructorService = InstructorService();
  final CourseService _courseService = CourseService();
  final BatchService _batchService = BatchService();

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  MyApp({Key key, @required this.authService, @required this.userService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SideDrawer sideDrawer =
        new SideDrawer(authService: authService, userService: userService);
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(
            userService: userService,
          ),
        ),
        BlocProvider<CollegesBloc>(
          create: (context) => CollegesBloc(collegeService: _collegeService)..add(CollegesLoaded()),
        ),
        BlocProvider<CollegeBloc>(
          create: (context) => CollegeBloc(collegeService: _collegeService),
        ),
        BlocProvider<AddPrincipalBloc>(
          create: (context) =>
              AddPrincipalBloc(collegeService: _collegeService),
        ),
        BlocProvider<AddInstructorBloc>(
          create: (context) =>
              AddInstructorBloc(instructorService: _instructorService),
        ),
        BlocProvider<CourseBloc>(
          create: (context) =>
              CourseBloc(courseService: _courseService),
        ),
        BlocProvider<BatchBloc>(
          create: (context) =>
              BatchBloc(batchService: _batchService),
        ),
      ],
      child: MaterialApp(
        title: 'UMS',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        darkTheme: AppTheme.darkTheme,
//            themeMode: themeState.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationAuthenticated) {
              return HomeScreen(
                sideDrawer: sideDrawer,
              );
            }
            if (state is AuthenticationUnauthenticated) {
              return LoginScreen(
                authService: authService,
                userService: userService,
              );
            }
            if (state is AuthenticationLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SplashPage();
          },
        ),
        routes: <String, WidgetBuilder>{
          '/CollegesScreen': (BuildContext context) =>
              new CollegesScreen(sideDrawer: sideDrawer),
          '/AddCollegeScreen': (BuildContext context) => new AddCollegeScreen(
                sideDrawer: sideDrawer,
                collegeService: _collegeService,
              ),
          '/MyProfileScreen': (BuildContext context) => new MyAccountsScreen(
              userService: userService, sideDrawer: sideDrawer),
          '/LoginScreen': (BuildContext context) => new LoginScreen(
              authService: authService, userService: userService)
        },
      ),
    );
  }
}
