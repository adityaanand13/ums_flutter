import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/college_bloc.dart';
import 'package:ums_flutter/event_state/college/college_event.dart';
import 'package:ums_flutter/models/response/college_response.dart';
import 'package:ums_flutter/utils/sizeConfig.dart';

class CollegeView extends StatelessWidget {
  final CollegeResponse collegeResponse;

  CollegeView({@required this.collegeResponse})
      : assert(collegeResponse != null);

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
          height: SizeConfig.safeBlockVertical * 65,
          width: SizeConfig.blockSizeHorizontal * 100,
          decoration: BoxDecoration(
              color: Color.fromRGBO(32, 32, 32, 0.96),
              borderRadius: BorderRadius.circular(24)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 24, left: 24, right: 24),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Center(
                          child: Text(
                            '${collegeResponse.code}',
                            style: TextStyle(
                              fontSize: 26,
                              color: Colors.blueAccent,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w700,
                              letterSpacing: 4,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          '${collegeResponse.name}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                'Description: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${collegeResponse.description}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ],
                          )),
                      Container(
                          padding: EdgeInsets.only(top: 10, bottom: 5),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                'Principal: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.lightGreenAccent,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '1317007',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              Text(
                                'Aditya Anand',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ],
                          )),
                      Divider(
                        height: SizeConfig.blockSizeVertical * 2.5,
                        thickness: 1,
                        color: Colors.blueAccent.withOpacity(0.3),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          'Address:',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          '${collegeResponse.address}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Divider(
                        height: SizeConfig.blockSizeVertical * 2.5,
                        thickness: 1,
                        color: Colors.blueAccent.withOpacity(0.3),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          'Courses:',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24),
                child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 5),
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      OutlineButton(
                        onPressed: () => Navigator.of(context).pushNamed(
                            '/courses_screen'),
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
                        onPressed: () => {print('hey')},
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
                        onPressed: () => BlocProvider.of<CollegeBloc>(context)
                            .add(CloseCollege()),
                        color: Colors.blueAccent,
                        child: Text(
                          'Back',
                          style: TextStyle(color: Colors.white,),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
