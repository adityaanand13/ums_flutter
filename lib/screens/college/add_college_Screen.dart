import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/college_bloc.dart';
import 'package:ums_flutter/event_state/college/college_event.dart';
import 'package:ums_flutter/event_state/college/college_state.dart';
import 'package:ums_flutter/models/request/college_request.dart';
import 'package:ums_flutter/utils/sizeConfig.dart';
import 'package:ums_flutter/widget/Side_drawer.dart';

class AddCollegeScreen extends StatefulWidget {
  final SideDrawer sideDrawer;

  const AddCollegeScreen({Key key, this.sideDrawer})
      : assert(sideDrawer != null),
        super(key: key);

  @override
  _AddCollegeScreenState createState() => _AddCollegeScreenState();
}

class _AddCollegeScreenState extends State<AddCollegeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final _nameFocus = FocusNode();
  final _codeFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _addressFocus = FocusNode();

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  _onCreateButtonPressed() {
    BlocProvider.of<CollegeBloc>(context).add(
      CreateCollegeButtonPressed(
          collegeRequest: CollegeRequest.create(
              name: _nameController.text,
              code: _codeController.text,
              description: _descriptionController.text,
              address: _addressController.text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.black,
      drawer: widget.sideDrawer,
      bottomNavigationBar: _bottomAppBar(context: context),
      body: SingleChildScrollView(
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
                                  colors: [Colors.black, Colors.transparent])
                              .createShader(
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
                        left: 12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Create',
                              style: TextStyle(
                                  fontFamily: 'Oswald',
                                  fontSize: SizeConfig.blockSizeHorizontal * 9,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            Row(
                              children: <Widget>[
                                Text('College',
                                    style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal * 10,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFFD3664))),
                              ],
                            )
                          ],
                        ), //move to a function
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(22),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _customTextField(
                          autofocus: true,
                          labelText: 'Name',
                          maxLength: 100,
                          minLength: 5,
                          context: context,
                          textEditingController: _nameController,
                          focusNode: _nameFocus,
                          nextFocusNode: _codeFocus,
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical * 1),
                        _customTextField(
                          maxLength: 10,
                          minLength: 3,
                          labelText: 'College Code',
                          context: context,
                          textEditingController: _codeController,
                          focusNode: _codeFocus,
                          nextFocusNode: _descriptionFocus,
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical * 1),
                        _customTextField(
                          maxLength: 255,
                          minLength: 10,
                          labelText: 'Description',
                          context: context,
                          textEditingController: _descriptionController,
                          focusNode: _descriptionFocus,
                          nextFocusNode: _addressFocus,
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical * 1),
                        _customTextField(
                          maxLength: 255,
                          minLength: 10,
                          labelText: 'Address',
                          isLastEntry: true,
                          context: context,
                          textEditingController: _addressController,
                          focusNode: _addressFocus,
                          nextFocusNode: _addressFocus,
                        ),
                        SizedBox(height: 40.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _customTextField({
    String labelText,
    bool autofocus = false,
    int maxLength = 100,
    int minLength = 3,
    BuildContext context,
    TextEditingController textEditingController,
    FocusNode focusNode,
    bool isLastEntry = false,
    FocusNode nextFocusNode,
  }) {
    return TextFormField(
      cursorColor: Colors.green,
      maxLength: maxLength,
      autofocus: autofocus,
      controller: textEditingController,
      style: TextStyle(
        color: Colors.white,
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      focusNode: focusNode,
      onFieldSubmitted: !isLastEntry
          ? (term) => _fieldFocusChange(context, focusNode, nextFocusNode)
          : (term) {
              focusNode.unfocus();
              _onCreateButtonPressed();
            },
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
            fontSize: SizeConfig.blockSizeHorizontal * 3.8,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.lightGreenAccent),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(112, 112, 112, 1)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.lightGreenAccent),
        ),
      ),
      autocorrect: true,
      validator: (String value) {
        return value.length < minLength
            ? 'Minimum Length Should be $minLength'
            : null;
      },
    );
  }

  Widget _bottomAppBar({BuildContext context}) {
    return BottomAppBar(
      color: Color.fromRGBO(32, 32, 32, 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          OutlineButton(
            child: Text(
              "Cancel",
              style: TextStyle(
                color: Colors.redAccent,
              ),
            ),
            borderSide: BorderSide(
              color: Colors.red,
              style: BorderStyle.solid,
              width: 0.8,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          RaisedButton(
            onPressed: () => _onCreateButtonPressed,
            color: Colors.green,
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
