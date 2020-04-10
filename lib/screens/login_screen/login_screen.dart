import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/authentication_bloc.dart';
import 'package:ums_flutter/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ums_flutter/bloc/navigation_bloc.dart';
import 'package:ums_flutter/services/auth_service.dart';
import 'package:ums_flutter/services/user_service.dart';
import 'package:ums_flutter/utils/sizeConfig.dart';

import 'login_form.dart';

class LoginScreen extends StatelessWidget with NavigationStates{
  final AuthService authService;
  final UserService userService;

  LoginScreen({Key key, @required this.authService, @required this.userService})
      : assert(authService != null),
        assert(userService != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: BlocProvider<LoginBloc>(
            create: (context) {
              return LoginBloc(
                authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
                authService: authService,
                userService: userService,
              );
            },
            child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                SizeConfig.blockSizeHorizontal * 2.5,
                                SizeConfig.blockSizeVertical * 13,
                                SizeConfig.blockSizeHorizontal * 2.5,
                                0.0),
                            child: Text(
                                'Welcome To',
                                style: TextStyle(
                                    fontSize: SizeConfig.blockSizeHorizontal *
                                        9.5,
                                    fontWeight: FontWeight.bold)
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                SizeConfig.blockSizeHorizontal * 2.5,
                                SizeConfig.blockSizeVertical * 18,
                                0.0,
                                0.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text('UMS Portal',
                                    style: TextStyle(
                                        fontSize: SizeConfig
                                            .blockSizeHorizontal * 15,
                                        fontWeight: FontWeight.bold)
                                ),
                                Text('.',
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                        fontSize: SizeConfig
                                            .blockSizeHorizontal * 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green)
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 13,
                            left: SizeConfig.blockSizeHorizontal * 5,
                            right: SizeConfig.blockSizeHorizontal * 5),
                        child: LoginForm()
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'New to UMS ?',
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 5.4,
                              fontFamily: 'Montserrat'),
                        ),
                        SizedBox(width: 5.0),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed(
                                '/signup');
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 5.4,
                                color: Colors.green,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                  ],
                )
            )
        )
    );
  }
}
