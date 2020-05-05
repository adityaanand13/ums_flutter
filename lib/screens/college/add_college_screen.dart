import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/college_bloc.dart';
import 'package:ums_flutter/components/header/page_header.dart';
import 'package:ums_flutter/components/input/text_form_field_validation.dart';
import 'package:ums_flutter/event_state/college/college_event.dart';
import 'package:ums_flutter/event_state/college/college_state.dart';
import 'package:ums_flutter/models/request/college_request.dart';
import 'package:ums_flutter/models/response/college_response.dart';
import 'package:ums_flutter/screens/college/add_principal.dart';
import 'package:ums_flutter/services/college_service.dart';
import 'package:ums_flutter/utils/sizeConfig.dart';
import 'package:ums_flutter/components/drawer/Side_drawer.dart';
import 'package:ums_flutter/validator/validator.dart';

class AddCollegeScreen extends StatefulWidget {
  final SideDrawer sideDrawer;
  final CollegeService collegeService;

  const AddCollegeScreen(
      {Key key, @required this.sideDrawer, @required this.collegeService})
      : assert(sideDrawer != null),
        assert(collegeService != null),
        super(key: key);

  @override
  _AddCollegeScreenState createState() => _AddCollegeScreenState();
}

class _AddCollegeScreenState extends State<AddCollegeScreen> {
  final _nameFocus = FocusNode();
  final _codeFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _addressFocus = FocusNode();

  CollegeRequest _collegeRequest = CollegeRequest();
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
                borderRadius: BorderRadius.circular(22),
                color: Color.fromRGBO(16, 16, 16, 1),
              ),
              width: SizeConfig.blockSizeHorizontal * 80,
              height: SizeConfig.blockSizeVertical * 30,
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(22),
                          topRight: Radius.circular(22)),
                      color: Color.fromRGBO(32, 32, 32, 1),
                    ),
                    height: SizeConfig.blockSizeVertical * 10,
                    padding: EdgeInsets.all(22),
                    child: Center(
                      child: Text(
                        'College Created',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.blockSizeHorizontal * 7,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Color.fromRGBO(16, 16, 16, 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'College Has been created succesfully. press Continue to add principal',
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
                            onPressed: () {
                              Navigator.of(context).push(
                                new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new AddPrincipalScreen(
                                    sideDrawer: widget.sideDrawer,
                                    collegeResponse: collegeResponse,
                                    collegeService: widget.collegeService,
                                  ),
                                ),
                              );
                            },
                          ),
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
    BlocProvider.of<CollegeBloc>(context).add(
      CreateCollegeButtonPressed(collegeRequest: _collegeRequest),
    );
  }

  final formKey = GlobalKey<FormState>();

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
        onPressed: () => BlocListener<CollegeBloc, CollegeState>(
          listener: (BuildContext context, state) {
            if (state is !CollegeLoading) {
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
            } else {
              return null;
            }
          },
        ),
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
      body: BlocListener<CollegeBloc, CollegeState>(
        listener: (BuildContext context, state) {
          if (state is CollegeAdded) {
            return _showDialog(state.collegeResponse);
          } else if (state is CollegeError) {
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
                          child: PageHeader(line1: "Add",line2: "College", marginBottom: 0,), //move to a function
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(22),
                    child: Form(
                        autovalidate: _autoValidate,
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormFieldValidation(
                              hint: "College Code",
                              initialValue: "MM",
                              focusNode: _codeFocus,
                              autofocus: true,
                              nextFocusNode: _nameFocus,
                              onValueChanged: (val) {
                                _collegeRequest.code = val.trim().toUpperCase();
                              },
                            ),
                            TextFormFieldValidation(
                              hint: "College Name",
                              initialValue: "MM ",
                              focusNode: _nameFocus,
                              nextFocusNode: _phoneFocus,
                              validator: (String arg) {
                                if (arg.length < 6)
                                  return 'Name must be more than 6 character';
                                else
                                  return null;
                              },
                              onValueChanged: (val) {
                                _collegeRequest.name = val.trim();
                              },
                            ),
                            TextFormFieldValidation(
                              hint: "Phone Number",
                              initialValue: "+91",
                              focusNode: _phoneFocus,
                              nextFocusNode: _emailFocus,
                              textInputFormatter: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(13)
                                ],
                              keyboardType:
                                  TextInputType.numberWithOptions(signed: true),
                              validator: Validator.validateMobile,
                              onValueChanged: (val) {
                                _collegeRequest.phone = val.trim();
                              },
                            ),
                            TextFormFieldValidation(
                              hint: "Email Address",
                              focusNode: _emailFocus,
                              keyboardType: TextInputType.emailAddress,
                              nextFocusNode: _addressFocus,
                              validator: Validator.validateEmail,
                              onValueChanged: (val) {
                                _collegeRequest.email = val.trim();
                              },
                            ),
                            TextFormFieldValidation(
                              hint: "Address",
                              focusNode: _emailFocus,
                              keyboardType: TextInputType.multiline,
                              nextFocusNode: _addressFocus,
                              onValueChanged: (val) {
                                _collegeRequest.address = val.trim();
                              },
                              isLastEntry: true,
                              onFormSubmit: _onSubmit,
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
