import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/college_bloc.dart';
import 'package:ums_flutter/bloc/navigation_bloc.dart';
import 'package:ums_flutter/event_state/college/college_event.dart';
import 'package:ums_flutter/event_state/college/college_state.dart';
import 'package:ums_flutter/models/request/college_request.dart';
import 'package:ums_flutter/utils/sizeConfig.dart';

class AddCollegeView extends StatefulWidget with NavigationStates {
  @override
  _AddCollegeViewState createState() => _AddCollegeViewState();
}

class _AddCollegeViewState extends State<AddCollegeView> {
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

  Future<bool> _onBackButtonPressed() {
    BlocProvider.of<CollegeBloc>(context).add(CloseCollege());
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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

    return WillPopScope(
      onWillPop: _onBackButtonPressed,
      child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          SizeConfig.blockSizeHorizontal * 2.5,
                          SizeConfig.blockSizeVertical * 13,
                          SizeConfig.blockSizeHorizontal * 2.5,
                          0.0),
                      child: Text('Create',
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 9.5,
                              fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          SizeConfig.blockSizeHorizontal * 2.5,
                          SizeConfig.blockSizeVertical * 18,
                          0.0,
                          0.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('New College',
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeHorizontal * 15,
                                  fontWeight: FontWeight.bold)),
                          Text('.',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeHorizontal * 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: BlocListener<CollegeBloc, CollegeState>(
                  listener: (context, state) {
                    if (state is CollegeError) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${state.error}'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<CollegeBloc, CollegeState>(
                    builder: (context, state) {
                      return Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _customTextField(
                              context: context,
                              textEditingController: _nameController,
                              focusNode: _nameFocus,
                              nextFocusNode: _codeFocus,
                            ),
                            SizedBox(
                                height: SizeConfig.blockSizeVertical * 2.5),
                            _customTextField(
                              context: context,
                              textEditingController: _codeController,
                              focusNode: _codeFocus,
                              nextFocusNode: _descriptionFocus,
                            ),
                            SizedBox(
                                height: SizeConfig.blockSizeVertical * 2.5),
                            _customTextField(
                              context: context,
                              textEditingController: _descriptionController,
                              focusNode: _descriptionFocus,
                              nextFocusNode: _addressFocus,
                            ),
                            SizedBox(
                                height: SizeConfig.blockSizeVertical * 2.5),
                            _customTextField(
                              context: context,
                              textEditingController: _addressController,
                              focusNode: _addressFocus,
                              nextFocusNode: _addressFocus,
                            ),
                            SizedBox(height: 40.0),
                            Container(
                              height: 35,
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                shadowColor: Colors.greenAccent,
                                color: Colors.green,
                                elevation: 7.0,
                                child: GestureDetector(
                                  onTap: state is! CollegeLoading
                                      ? _onCreateButtonPressed
                                      : null,
                                  child: state is CollegeLoading
                                      ? Container(
                                          child: state is CollegeLoading
                                              ? CircularProgressIndicator()
                                              : null,
                                        )
                                      : Center(
                                          child: Text(
                                            'SUBMIT',
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  5,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                OutlineButton(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid,
                                    width: 0.8,
                                  ),
                                  onPressed: () =>
                                      BlocProvider.of<CollegeBloc>(context)
                                          .add(CloseCollege()),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                                RaisedButton(
                                  onPressed: _onCreateButtonPressed,
                                  color: Colors.greenAccent,
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      );
  }

  Widget _customTextField(
      {BuildContext context,
      TextEditingController textEditingController,
      FocusNode focusNode,
      FocusNode nextFocusNode}) {
    return TextFormField(
      controller: textEditingController,
      style: TextStyle(
        color: Colors.white,
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      focusNode: focusNode,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, focusNode, nextFocusNode);
      },
      decoration: InputDecoration(
          labelText: 'College Name',
          labelStyle: TextStyle(
              fontSize: SizeConfig.blockSizeHorizontal * 3.8,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.white),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green))),
    );
  }
}
