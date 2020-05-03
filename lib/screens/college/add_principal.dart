import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/add_princiapal_bloc.dart';
import 'package:ums_flutter/components/buttons/flat_button_custom.dart';
import 'package:ums_flutter/components/header/page_header.dart';
import 'package:ums_flutter/components/input/text_form_field_validation.dart';
import 'package:ums_flutter/event_state/add_principal/add_principal_event.dart';
import 'package:ums_flutter/event_state/add_principal/add_principal_state.dart';
import 'package:ums_flutter/models/response/college_response.dart';
import 'package:ums_flutter/services/college_service.dart';
import 'package:ums_flutter/utils/sizeConfig.dart';
import 'package:ums_flutter/components/drawer/Side_drawer.dart';

class AddPrincipalScreen extends StatefulWidget {
  final SideDrawer sideDrawer;
  final CollegeResponse collegeResponse;
  final CollegeService collegeService;

  AddPrincipalScreen(
      {Key key,
      @required this.sideDrawer,
      @required this.collegeResponse,
      @required this.collegeService})
      : assert(collegeResponse != null),
        assert(sideDrawer != null),
        assert(collegeService != null),
        super(key: key);

  @override
  _AddPrincipalScreenState createState() => _AddPrincipalScreenState();
}

class _AddPrincipalScreenState extends State<AddPrincipalScreen> {
  String _username;

  final formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 1),
      drawer: widget.sideDrawer,
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Builder(
              builder: (context) => IconButton(
                disabledColor: Colors.white12,
                icon: Icon(Icons.list),
                color: Colors.white,
                onPressed: null,
              ),
            ),
          ],
        ),
        color: Color(0xff101010),
      ),
      body: SafeArea(
        bottom: false,
        child: BlocListener<AddPrincipalBloc, AddPrincipalState>(
          listener: (BuildContext context, state) {
            if (state is PrincipalAdded) {
              _showDialog();
            } else if (state is AddPrincipalError) {
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
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  padding: EdgeInsets.only(left: 22, right: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      PageHeader(
                        line1: "Assign",
                        line2: "Principal",
                        marginTop: 40,
                        marginBottom: 20,
                      ),
                      Form(
                        autovalidate: _autoValidate,
                        key: formKey,
                        child: TextFormFieldValidation(
                          hint: "Employee Username",
                          onValueChanged: (val) {
                            _username = val.trim();
                          },
                          isLastEntry: true,
                          validator: (String value) {
                            return value.length < 4
                                ? 'Minimum Length Should be 4'
                                : null;
                          },
                          onFormSubmit: _onAddButtonPressed,
                        ),
                      ),
                      FlatButtonCustom(
                        title: "Assign",
                        iconData: Icons.assignment_ind,
                        onTap: () {
                          if (formKey.currentState.validate()) {
                            _onAddButtonPressed(context);
                          } else {
                            _autoValidate = true;
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onAddButtonPressed(BuildContext context) {
    BlocProvider.of<AddPrincipalBloc>(context).add(
      AddButtonPressed(
          username: _username, collegeId: widget.collegeResponse.id),
    );
  }

  void _showDialog() {
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
              height: 100,
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
                        'Principal Added',
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
                          'Principal has been assigned succesfully to the college ${widget.collegeResponse.name} \npress done to view college details',
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
                              "Done",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil("/CollegesScreen", (Route<dynamic> route) => false);
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
}
