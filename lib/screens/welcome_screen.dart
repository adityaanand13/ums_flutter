import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ums_flutter/utils/sizeConfig.dart';
import 'package:ums_flutter/utils/styles.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color.fromARGB(255, 47, 0, 0),
                Color.fromARGB(255, 250, 2, 18),
                Color.fromARGB(255, 235, 35, 48),
                Color.fromARGB(255,120, 11, 18),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 6),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 2,
                          bottom: SizeConfig.blockSizeVertical * 2,
                          left: SizeConfig.blockSizeHorizontal * 1,
                          right: SizeConfig.blockSizeHorizontal * 1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Image(
//                              fit: BoxFit.fitHeight,
                              image: AssetImage(
                                'images/UniLogo.png',
                              ),
                              height:  SizeConfig.blockSizeVertical * 35,
                              width:  SizeConfig.blockSizeHorizontal * 45,
                            ),
                          ),
                          Center(
                              child: Text(
                                'M M D U',
                                textAlign: TextAlign.center,
                                style: kTitleStyle(context),
                              )),
                          SizedBox(height: SizeConfig.blockSizeVertical * 0.5),
                          Center(
                              child: Text(
                                  'Maharishi Markendeshwar\n(Deemed to be University)',
                                  textAlign: TextAlign.center,
                                  style: kSubtitleStyle(context)
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 8),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 3),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/profile');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Get Started',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.safeBlockHorizontal * 8,
                            ),
                          ),
                          SizedBox(width: SizeConfig.safeBlockHorizontal * 6),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                            size: SizeConfig.safeBlockHorizontal * 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
