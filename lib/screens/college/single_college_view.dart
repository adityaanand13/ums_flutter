import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ums_flutter/models/response/college_response.dart';
import 'package:ums_flutter/screens/college/detailed_college_screen.dart';
import 'package:ums_flutter/utils/sizeConfig.dart';
import 'package:ums_flutter/components/drawer/side_drawer.dart';

class CollegeView extends StatelessWidget {
  final CollegeResponse collegeResponse;
  final Function changeState;
  final SideDrawer sideDrawer;

  CollegeView(
      {@required this.collegeResponse, @required this.changeState, @required this.sideDrawer})
      : assert(collegeResponse != null),
        assert(sideDrawer != null);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Positioned(
      bottom: 0,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 4,
          sigmaY: 4,
        ),
        child: Container(
          width: SizeConfig.blockSizeHorizontal * 100,
          decoration: BoxDecoration(
              color: Color.fromRGBO(13, 13, 13, 0.96),
              borderRadius: BorderRadius.circular(18)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Center(
                          child: Text(
                            '${collegeResponse.code}',
                            style: TextStyle(
                              fontSize: 26,
                              color: Color(0xFFFD3664),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          '${collegeResponse.name}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 15, bottom: 5),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                'Principal: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFFD3664),
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                '1317007',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Aditya Anand',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 15, bottom: 10),
                        child: Text(
                          'Address:',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFFD3664),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(bottom: 15),
                        child: Text(
                          '${collegeResponse.address}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            OutlineButton(
                              onPressed: () =>
                                  Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                        new DetailedCollegeScreen(sideDrawer:sideDrawer, collegeResponse: collegeResponse,)
                                    ),),
                              borderSide: BorderSide(
                                color: Colors.amber,
                                style: BorderStyle.solid,
                                width: 0.8,
                              ),
                              child: Text(
                                'Detailed View',
                                style: TextStyle(color: Colors.amberAccent,),
                              ),
                            ),
                            OutlineButton(
                              onPressed: () => {},
                              borderSide: BorderSide(
                                color: Colors.lightGreen,
                                style: BorderStyle.solid,
                                width: 0.8,
                              ),
                              child: Text(
                                'Modify',
                                style: TextStyle(color: Colors.lightGreenAccent,),
                              ),
                            ),
                            RaisedButton(
                              onPressed: () => changeState(null),
                              color: Colors.blueAccent,
                              child: Text(
                                'Back',
                                style: TextStyle(color: Colors.white,),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
