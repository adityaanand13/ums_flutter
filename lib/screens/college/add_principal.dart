import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/add_princiapal_bloc.dart';
import 'package:ums_flutter/event_state/add_principal/add_principal_event.dart';
import 'package:ums_flutter/event_state/add_principal/add_principal_state.dart';
import 'package:ums_flutter/models/response/college_response.dart';
import 'package:ums_flutter/services/college_service.dart';
import 'package:ums_flutter/utils/sizeConfig.dart';
import 'package:ums_flutter/widget/Side_drawer.dart';

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
  final TextEditingController _usernameEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 1),
      drawer: widget.sideDrawer,
      appBar: AppBar(
        title: Text('Asiign Principal'),
        backgroundColor: Color.fromRGBO(32, 32, 32, 1),
      ),
      body: BlocListener<AddPrincipalBloc, AddPrincipalState>(
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
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
            ),
            padding: EdgeInsets.only(left: 22, right: 22),
            child: Column(
              children: <Widget>[
                TextFormField(
                  cursorColor: Colors.green,
                  controller: _usernameEditingController,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Employee Username",
                    labelStyle: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.lightGreenAccent),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(112, 112, 112, 1)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightGreenAccent),
                    ),
                  ),
                  autocorrect: true,
                  validator: (String value) {
                    return value.length < 3
                        ? 'Minimum Length Should be 3'
                        : null;
                  },
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 2),
                Container(
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    color: Colors.lightGreen,
                    child: Text(
                      "Continue",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => _onAddButtonPressed(context),
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
          username: _usernameEditingController.text,
          collegeId: widget.collegeResponse.id),
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
                          'Principal has been assigned succesfully to the college ${widget.collegeResponse.name} \n press done to view college details',
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
//                              Navigator.of(context).push(),
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
