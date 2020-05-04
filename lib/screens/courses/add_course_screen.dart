import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/college_bloc.dart';
import 'package:ums_flutter/bloc/course_bloc.dart';
import 'package:ums_flutter/components/header/page_header.dart';
import 'package:ums_flutter/components/input/text_form_field_validation.dart';
import 'package:ums_flutter/event_state/college/college_state.dart';
import 'package:ums_flutter/event_state/course/course_event.dart';
import 'package:ums_flutter/event_state/course/course_state.dart';
import 'package:ums_flutter/models/request/course_request.dart';
import 'package:ums_flutter/models/response/college_response.dart';
import 'package:ums_flutter/models/response/course_response.dart';
import 'package:ums_flutter/utils/sizeConfig.dart';
import 'package:ums_flutter/components/drawer/Side_drawer.dart';

class AddCourseScreen extends StatefulWidget {
  final SideDrawer sideDrawer;
  final int collegeID;

  const AddCourseScreen(
      {Key key, @required this.sideDrawer, @required this.collegeID})
      : assert(sideDrawer != null),
        super(key: key);

  @override
  _AddCourseScreenState createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final _nameFocus = FocusNode();
  final _codeFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _durationFocus = FocusNode();
  final _semesterPerYear = FocusNode();

  CourseRequest _courseRequest = CourseRequest();
  bool _autoValidate = false;

  _onSubmit(BuildContext context) {
    if (formKey.currentState.validate()) {
      _onCreateButtonPressed(context);
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  //todo refactor to college response
  void _showDialog(CollegeResponse collegeResponse) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Color.fromRGBO(16, 16, 16, 1),
              ),
              width: SizeConfig.blockSizeHorizontal * 80,
              height: SizeConfig.blockSizeVertical * 30,
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18)),
                      color: Color.fromRGBO(32, 32, 32, 1),
                    ),
                    height: SizeConfig.blockSizeVertical * 10,
                    padding: EdgeInsets.all(22),
                    child: Center(
                      child: Text(
                        'Course Added',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.blockSizeHorizontal * 7,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Color.fromRGBO(16, 16, 16, 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Course Added Successfully\nPress Continue to go back to College Screen',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: SizeConfig.blockSizeHorizontal * 3.75,
                          ),
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical * 2),
                        Center(
                          child: RaisedButton(
                              color: Colors.lightGreen,
                              child: Text(
                                "Continue",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {}),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _onCreateButtonPressed(BuildContext context) {
    BlocProvider.of<CourseBloc>(context).add(CreateCourse(
        collegeId: widget.collegeID, courseRequest: _courseRequest));
  }

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.black,
      drawer: widget.sideDrawer,
      floatingActionButton: new FloatingActionButton.extended(
        backgroundColor: Colors.green,
        icon: Icon(Icons.cloud_done),
        label: Text(
          'Save',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
        onPressed: () {
          print('hello');
          if (formKey.currentState.validate()) {
            _onCreateButtonPressed(context);
          } else {
            //    If all data are not valid then start auto validation.
            setState(
                  () {
                _autoValidate = true;
              },
            );
          }
//          return BlocListener<CourseBloc, CourseState>(
//            listener: (BuildContext context, state) {
//              print('hello2');
//              if (state is! CourseLoading) {
//                if (formKey.currentState.validate()) {
//                  _onCreateButtonPressed(context);
//                } else {
//                  //    If all data are not valid then start auto validation.
//                  setState(
//                    () {
//                      _autoValidate = true;
//                    },
//                  );
//                }
//              } else {
//                return null;
//              }
//            },
//          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.list),
                color: Colors.white,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.close),
              color: Colors.red,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        color: Color(0xff101010),
      ),
      body: BlocListener<CourseBloc, CourseState>(
        listener: (BuildContext context, state) {
          if (state is CourseCreated) {
            return _showDialog(state.collegeResponse);
          } else if (state is CourseError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Container(
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: SizeConfig.blockSizeVertical * 37.5,
                    width: SizeConfig.screenWidth,
                    child: Stack(
                      children: <Widget>[
                        ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black,
                                  Colors.transparent
                                ]).createShader(
                                Rect.fromLTRB(0, 0, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstIn,
                          //todo change image
                          child: Image.asset('images/university.jpg',
                              alignment: Alignment.topCenter,
                              width: SizeConfig.screenWidth,
                              height: SizeConfig.blockSizeVertical * 37.5,
                              fit: BoxFit.fill),
                        ),
                        Positioned(
                          bottom: SizeConfig.blockSizeVertical * 2,
                          left: 18,
                          child: PageHeader(
                            line1: "Add",
                            line2: "Course",
                            marginBottom: 0,
                          ), //move to a function
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(18),
                    child: Form(
                        autovalidate: _autoValidate,
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormFieldValidation(
                              hint: "Course Code",
                              focusNode: _codeFocus,
                              autofocus: true,
                              nextFocusNode: _nameFocus,
                              onValueChanged: (val) {
                                _courseRequest.code = val.trim().toUpperCase();
                              },
                            ),
                            TextFormFieldValidation(
                              hint: "Course Name",
                              focusNode: _nameFocus,
                              nextFocusNode: _descriptionFocus,
                              validator: (String arg) {
                                if (arg.length < 6)
                                  return 'Name must be more than 6 character';
                                else
                                  return null;
                              },
                              onValueChanged: (val) {
                                _courseRequest.name = val.trim();
                              },
                            ),
                            TextFormFieldValidation(
                              hint: "Description",
                              focusNode: _descriptionFocus,
                              nextFocusNode: _durationFocus,
                              onValueChanged: (val) {
                                _courseRequest.description = val.trim();
                              },
                            ),
                            TextFormFieldValidation(
                              hint: "Duration in Years",
                              focusNode: _durationFocus,
                              nextFocusNode: _semesterPerYear,
                              keyboardType: TextInputType.numberWithOptions(
                                  signed: false, decimal: false),
                              textInputFormatter: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(1)
                              ],
                              validator: (val) {
                                try {
                                  if (int.parse(val) < 1 &&
                                      int.parse(val) > 9) {
                                    return "value must be in range 0-9";
                                  } else {
                                    return null;
                                  }
                                } catch (e) {
                                  return "Only digits allowed";
                                }
                              },
                              onValueChanged: (val) {
                                _courseRequest.duration = int.tryParse(val.trim());
                              },
                            ),
                            TextFormFieldValidation(
                              hint: "Semesters Per Year",
                              focusNode: _semesterPerYear,
                              keyboardType: TextInputType.numberWithOptions(
                                  signed: false, decimal: false),
                              isLastEntry: true,
                              onFormSubmit: _onSubmit,
                              textInputFormatter: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(1)
                              ],
                              validator: (val) {
                                try {
                                  if (int.parse(val) < 1 &&
                                      int.parse(val) > 9) {
                                    return "value must be in range 0-9";
                                  } else {
                                    return null;
                                  }
                                } catch (e) {
                                  return "Only digits allowed";
                                }
                              },
                              onValueChanged: (val) {
                                _courseRequest.semesterPerYear = int.tryParse(val.trim());
                              },
                            ),
                            SizedBox(height: 10),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
