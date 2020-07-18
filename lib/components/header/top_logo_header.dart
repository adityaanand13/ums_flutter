import 'package:flutter/material.dart';

class TopLogoHeader extends StatefulWidget {
  @override
  _TopLogoHeaderState createState() => _TopLogoHeaderState();
}

class _TopLogoHeaderState extends State<TopLogoHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Maharishi Markandeshwar',
          style: TextStyle(
              letterSpacing: 1,
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Color(0xFFFD3664)),
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          '(Deemed to be University)',
          style: TextStyle(
              letterSpacing: 2,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        SizedBox(
          height: 5,
        ),
        Divider(
          thickness: 1,
          color: Color(0xCCFD3664),
        ),
      ],
    );
  }
}
