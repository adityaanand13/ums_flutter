import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/bloc.dart';
import 'package:ums_flutter/models/instructor_model.dart';
import 'package:ums_flutter/screens/instructor/instructor_detail_screen.dart';
import 'package:ums_flutter/utils/sizeConfig.dart';
import 'package:ums_flutter/components/drawer/side_drawer.dart';

class AddInstructorScreen extends StatefulWidget {
  final SideDrawer sideDrawer;

  const AddInstructorScreen({Key key, @required this.sideDrawer})
      : assert(sideDrawer != null),
        super(key: key);

  @override
  _AddInstructorScreenState createState() => _AddInstructorScreenState();
}

class _AddInstructorScreenState extends State<AddInstructorScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _bloodController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _religionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  final _usernameFocus = FocusNode();
  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _genderFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _bloodFocus = FocusNode();
  final _religionFocus = FocusNode();
  final _categoryFocus = FocusNode();
  final _aadharFocus = FocusNode();
  final _addressFocus = FocusNode();
  final _cityFocus = FocusNode();
  final _stateFocus = FocusNode();
  final _pincodeFocus = FocusNode();
  final _countryFocus = FocusNode();
  final _dobFocus = FocusNode();

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  //todo refactor to user response
  void _showDialog(InstructorModel newInstructor) {
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
                        'Instructor Created',
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
                          'Instructor has been created succesfully. press Continue to Show details',
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
                                      new InstructorDetailScreen(
                                    instructor: newInstructor,
                                    sideDrawer: widget.sideDrawer,
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
    InstructorModel newInstructor = InstructorModel.create(
        username: _usernameController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        gender: _genderController.text,
        phone: _phoneController.text,
        blood: _bloodController.text,
        religion: _religionController.text,
        category: _categoryController.text,
        aadhar: int.parse(_aadharController.text),
        address: _addressController.text,
        city: _cityController.text,
        state: _stateController.text,
        pinCode: int.parse(_pincodeController.text),
        country: _countryController.text,
        userType: "INSTRUCTOR",
        password: "12345678",
        dob: _dobController.text);
    BlocProvider.of<AddInstructorBloc>(context)
        .add(AddInstructorSubmitted(instructor: newInstructor));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Instructor'),
        backgroundColor: Color.fromRGBO(32, 32, 32, 1),
      ),
      backgroundColor: Colors.black,
      drawer: widget.sideDrawer,
      body: BlocListener<AddInstructorBloc, AddInstructorState>(
        listener: (BuildContext context, state) {
          if (state is AddInstructorSuccess) {
            return _showDialog(state.instructor);
          } else if (state is AddInstructorError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 6),
              ),
            );
          }
        },
        child: BlocBuilder(
          bloc: BlocProvider.of<AddInstructorBloc>(context),
          builder: (BuildContext context, AddInstructorState state) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 22, bottom: 22),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Color.fromRGBO(32, 32, 32, 1),
                        ),
                        padding: EdgeInsets.all(22),
                        child: Column(
                          children: <Widget>[
                            _customTextField(
                              autofocus: true,
                              maxLength: 10,
                              minLength: 3,
                              labelText: 'Username',
                              context: context,
                              textEditingController: _usernameController,
                              focusNode: _usernameFocus,
                              nextFocusNode: _firstNameFocus,
                            ),
                            SizedBox(height: 11),
                            _customTextField(
                              labelText: 'First Name',
                              maxLength: 100,
                              minLength: 5,
                              context: context,
                              textEditingController: _firstNameController,
                              focusNode: _firstNameFocus,
                              nextFocusNode: _lastNameFocus,
                            ),
                            SizedBox(height: 11),
                            _customTextField(
                              maxLength: 255,
                              minLength: 10,
                              labelText: 'Last Name',
                              context: context,
                              textEditingController: _lastNameController,
                              focusNode: _lastNameFocus,
                              nextFocusNode: _emailFocus,
                            ),
                            SizedBox(height: 11),
                            _customTextField(
                              maxLength: 255,
                              minLength: 10,
                              labelText: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              isLastEntry: true,
                              context: context,
                              textEditingController: _emailController,
                              focusNode: _emailFocus,
                              nextFocusNode: _dobFocus,
                            ),
                            SizedBox(height: 11),
                            _customTextField(
                              maxLength: 255,
                              minLength: 10,
                              labelText: 'Date Of Birth (YYYY-mm-DD)',
                              isLastEntry: true,
                              context: context,
                              textEditingController: _dobController,
                              focusNode: _dobFocus,
                              nextFocusNode: _phoneFocus,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 22),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Color.fromRGBO(32, 32, 32, 1),
                        ),
                        padding: EdgeInsets.all(22),
                        child: Column(
                          children: <Widget>[
                            _customTextField(
                              autofocus: true,
                              maxLength: 10,
                              minLength: 3,
                              labelText: 'Phone',
                              keyboardType: TextInputType.numberWithOptions(
                                  signed: false, decimal: false),
                              context: context,
                              textEditingController: _phoneController,
                              focusNode: _phoneFocus,
                              nextFocusNode: _genderFocus,
                            ),
                            SizedBox(height: 11),
                            _customTextField(
                              labelText: 'Gender',
                              maxLength: 100,
                              minLength: 5,
                              context: context,
                              textEditingController: _genderController,
                              focusNode: _genderFocus,
                              nextFocusNode: _bloodFocus,
                            ),
                            SizedBox(height: 11),
                            _customTextField(
                              maxLength: 255,
                              minLength: 10,
                              labelText: 'Blood Group',
                              context: context,
                              textEditingController: _bloodController,
                              focusNode: _bloodFocus,
                              nextFocusNode: _aadharFocus,
                            ),
                            SizedBox(height: 11),
                            _customTextField(
                              maxLength: 255,
                              minLength: 10,
                              labelText: 'Aadhar Number',
                              isLastEntry: true,
                              context: context,
                              keyboardType: TextInputType.numberWithOptions(
                                  signed: false, decimal: false),
                              textEditingController: _aadharController,
                              focusNode: _aadharFocus,
                              nextFocusNode: _religionFocus,
                            ),
                            SizedBox(height: 11),
                            _customTextField(
                              maxLength: 255,
                              minLength: 10,
                              labelText: 'Religion',
                              isLastEntry: true,
                              context: context,
                              textEditingController: _religionController,
                              focusNode: _religionFocus,
                              nextFocusNode: _categoryFocus,
                            ),
                            _customTextField(
                              maxLength: 255,
                              minLength: 10,
                              labelText: 'Category',
                              isLastEntry: true,
                              context: context,
                              textEditingController: _categoryController,
                              focusNode: _categoryFocus,
                              nextFocusNode: _addressFocus,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 22),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Color.fromRGBO(32, 32, 32, 1),
                        ),
                        padding: EdgeInsets.all(22),
                        child: Column(
                          children: <Widget>[
                            _customTextField(
                              autofocus: true,
                              maxLength: 10,
                              minLength: 3,
                              labelText: 'Address',
                              context: context,
                              textEditingController: _addressController,
                              focusNode: _addressFocus,
                              nextFocusNode: _cityFocus,
                            ),
                            SizedBox(height: 11),
                            _customTextField(
                              labelText: 'City',
                              maxLength: 100,
                              minLength: 5,
                              context: context,
                              textEditingController: _cityController,
                              focusNode: _cityFocus,
                              nextFocusNode: _stateFocus,
                            ),
                            SizedBox(height: 11),
                            _customTextField(
                              maxLength: 255,
                              minLength: 10,
                              labelText: 'State',
                              context: context,
                              textEditingController: _stateController,
                              focusNode: _stateFocus,
                              nextFocusNode: _pincodeFocus,
                            ),
                            SizedBox(height: 11),
                            _customTextField(
                              maxLength: 255,
                              minLength: 10,
                              labelText: 'Pincode',
                              isLastEntry: true,
                              keyboardType: TextInputType.numberWithOptions(
                                  signed: false, decimal: false),
                              context: context,
                              textEditingController: _pincodeController,
                              focusNode: _pincodeFocus,
                              nextFocusNode: _addressFocus,
                            ),
                            SizedBox(height: 11),
                            _customTextField(
                              maxLength: 255,
                              minLength: 10,
                              labelText: 'Country',
                              isLastEntry: true,
                              context: context,
                              textEditingController: _countryController,
                              focusNode: _countryFocus,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 22),
                      Container(
                        height: 35,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.greenAccent,
                          color: Colors.green,
                          elevation: 3.0,
                          child: GestureDetector(
                            onTap: state is! AddInstructorLoadInProgress
                                ? () => _onCreateButtonPressed(context)
                                : null,
                            child: state is AddInstructorLoadInProgress
                                ? Container(
                                    child: CircularProgressIndicator(),
                                  )
                                : Center(
                                    child: Text(
                                      'SUBMIT',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  5,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat'),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: 11),
                      Container(
                        height: 35,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.redAccent,
                          color: Colors.red,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              Navigator.of(context).pop();
                            },
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 5,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
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
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      cursorColor: Colors.green,
      maxLength: maxLength,
      autofocus: autofocus,
      controller: textEditingController,
      style: TextStyle(
        color: Colors.white,
      ),
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      focusNode: focusNode,
      onFieldSubmitted: !isLastEntry
          ? (term) => _fieldFocusChange(context, focusNode, nextFocusNode)
          : (term) {
              focusNode.unfocus();
              _onCreateButtonPressed(context);
            },
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
            fontSize: SizeConfig.blockSizeHorizontal * 3.8,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.lightGreen),
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
}
