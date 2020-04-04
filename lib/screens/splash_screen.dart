import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(image: AssetImage('images/UniLogo.png'),),
      ),
    );
  }
}