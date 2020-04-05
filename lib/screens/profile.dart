import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Image.asset(
            "images/profile.jpg",
            height: 600,
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.hue,
            color: Colors.black,
          ),
          Expanded(
              child: Container(
            height: 300,
            color: Colors.teal,
          )),
        ],
      ),
    );
  }
}
