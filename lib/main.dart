import 'package:flutter/material.dart';
import 'package:ums_flutter/screens/home.dart';
import 'package:ums_flutter/screens/login.dart';
import 'package:ums_flutter/screens/profile.dart';
import 'package:ums_flutter/screens/signup.dart';

import 'package:ums_flutter/services/auth.service.dart';


AuthService appAuth = new AuthService();


void main() async{
  // Set default home.
  Widget _defaultHome = new LoginPage();

  // Get result of the is logged in function.
  bool _result = await appAuth.isLoggedIn();
  if (_result) {
    _defaultHome = new HomePage();
  }

  runApp(new MaterialApp(
    title: 'UMS',
    debugShowCheckedModeBanner: false,
    home: _defaultHome,
    routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      '/home': (BuildContext context) => new HomePage(),
      '/login': (BuildContext context) => new LoginPage(),
      '/signup': (BuildContext context) => new SignupPage(),
      '/profile': (BuildContext context) => new Profile(),
    },
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
  ));
}
