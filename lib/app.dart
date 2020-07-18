import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/api/api.dart';
import 'package:ums_flutter/bloc/bloc.dart';
import 'package:ums_flutter/screens/screens.dart';
import 'package:ums_flutter/services/group_service.dart';
import 'package:ums_flutter/services/services.dart';
import 'package:ums_flutter/utils/utils.dart';
import 'package:ums_flutter/components/components.dart';

class MyApp extends StatelessWidget {
  final AuthService authService;
  final UserService userService;

  MyApp({
    Key key,
    @required this.authService,
    @required this.userService,
  }) : super(key: key);

  final CollegeService _collegeService = CollegeService(
    storageApiProvider: storageApiProvider,
    serverApiProvider: serverApiProvider,
  );
  final InstructorService _instructorService = InstructorService(
    storageApiProvider: storageApiProvider,
    serverApiProvider: serverApiProvider,
  );
  final CourseService _courseService = CourseService(
      storageApiProvider: storageApiProvider,
      serverApiProvider: serverApiProvider);
  final BatchService _batchService = BatchService(
      storageApiProvider: storageApiProvider,
      serverApiProvider: serverApiProvider);
  final SemesterService _semesterService = SemesterService(
    storageApiProvider: storageApiProvider,
    serverApiProvider: serverApiProvider,
  );
  final GroupService _groupService = GroupService(
      serverApiProvider: serverApiProvider
  );

  @override
  Widget build(BuildContext context) {
    SideDrawer sideDrawer =
    new SideDrawer(authService: authService, userService: userService);
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) =>
              UserBloc(
                userService: userService,
              ),
        ),
        BlocProvider<GroupBloc>(
          create: (context) => GroupBloc(groupService: _groupService),
        ),
        BlocProvider<SemesterBloc>(
          create: (context) => SemesterBloc(semesterService: _semesterService),
        ),
        BlocProvider<BatchBloc>(
          create: (context) =>
              BatchBloc(
                  batchService: _batchService,
                  semesterBloc: BlocProvider.of<SemesterBloc>(context)),
        ),
        BlocProvider<CourseBloc>(
          create: (context) =>
              CourseBloc(
                  courseService: _courseService,
                  batchBloc: BlocProvider.of<BatchBloc>(context)),
        ),
        BlocProvider<CollegesBloc>(
          create: (context) =>
          CollegesBloc(
            collegeService: _collegeService,
            courseBloc: BlocProvider.of<CourseBloc>(context),
          )
            ..add(CollegesLoaded()),
        ),
        BlocProvider<PrincipalBloc>(
          create: (context) =>
              PrincipalBloc(
                  instructorService: _instructorService,
                  collegeService: _collegeService),
        ),
        BlocProvider<AddInstructorBloc>(
          create: (context) =>
              AddInstructorBloc(instructorService: _instructorService),
        ),
      ],
      child: MaterialApp(
        title: 'UMS',
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        darkTheme: AppTheme.darkTheme,
//            themeMode: themeState.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            switch (state) {
              case AuthenticationState.AuthenticationUninitialized:
                return TransitionScreen(
                  child: Icon(
                    Icons.school,
                    color: Colors.white,
                  ),
                );
              case AuthenticationState.AuthenticationAuthenticated:
                return HomeScreen(
                  sideDrawer: sideDrawer,
                );
              case AuthenticationState.AuthenticationLoading:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case AuthenticationState.AuthenticationUnauthenticated:
                return LoginScreen(
                  authService: authService,
                  userService: userService,
                );
              case AuthenticationState.AuthenticationError:
              default:
                return SplashPage();
            }
          },
        ),
        routes: <String, WidgetBuilder>{
          '/CollegesScreen': (BuildContext context) =>
          new CollegesScreen(sideDrawer: sideDrawer),
          '/MyProfileScreen': (BuildContext context) =>
          new MyAccountsScreen(
              userService: userService, sideDrawer: sideDrawer),
          '/LoginScreen': (BuildContext context) =>
          new LoginScreen(
              authService: authService, userService: userService)
        },
      ),
    );
  }
}
