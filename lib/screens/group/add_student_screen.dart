import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ums_flutter/bloc/bloc.dart';
import 'package:ums_flutter/components/components.dart';
import 'package:ums_flutter/components/input/drop_down_field_validation.dart';
import 'package:ums_flutter/models/models.dart';
import 'package:ums_flutter/utils/utils.dart';
import 'package:ums_flutter/validator/validator.dart';

class AddStudentScreen extends StatefulWidget {
  final SideDrawer sideDrawer;
  final int groupId;

  const AddStudentScreen(
      {Key key, @required this.sideDrawer, @required this.groupId})
      : super(key: key);

  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Student _student;
  bool _autoValidate;
  bool _reqSubmitted;
  int _familyIncome;

  @override
  void initState() {
    _familyIncome = 0;
    _student = Student();
    _autoValidate = false;
    _reqSubmitted = false;
    super.initState();
  }

  _onSubmit(BuildContext context) {
    print(_student.toJson());
    if (_formKey.currentState.validate()) {
      _reqSubmitted = true;

      _student.password = _student.username + _student.pinCode.toString();

      BlocProvider.of<GroupBloc>(context).add(
        GroupAddStudent(student: _student),
      );
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: widget.sideDrawer,
      floatingActionButton: CustomFloatingActionButton(
        label: "Save",
        icon: Icon(Icons.cloud_done, color: Colors.white),
        color: Colors.green,
        onPressed: () {
          HapticFeedback.lightImpact();
          _onSubmit(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavigationBar(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.cancel,
          color: Colors.red,
        ),
      ),
      body: BlocListener<GroupBloc, GroupState>(
        listener: (BuildContext context, state){
          if(state is GroupLoadSuccessWithNewStudent){
            return customButtonDialog(
              context: context,
              header: "Student Added",
              data: "Student profile with username ${_student.username} has been added to This group.\n Press Continue to go back",
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            );
          }
        },
        child: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: SIDE_MARGIN),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PageHeader(line1: "Add", line2: "Student"),
                    Form(
                      autovalidate: _autoValidate,
                      key: _formKey,
                      child: Column(
                        children: [
                          _personalDetails(context),
                          SizedBox(height: 18),
                          _familyDetails(context),
                          SizedBox(height: 18),
                          _addressDetails(context),
                          SizedBox(height: 18),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget _personalDetails(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: Color.fromRGBO(32, 32, 32, 1),
      ),
      child: Column(
        children: [
          Center(
            child: Text(
              "Personal Details",
              style: TextStyle(
                fontSize: 22,
                color: Color(0xFFFD3664),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            height: 9,
          ),
          TextFormFieldValidation(
            label: "Username",
            validator: (String arg) {
              if (arg.length < 6)
                return 'Name must be more than 6 character';
              else
                return null;
            },
            onValueChanged: (val) {
              _student.username = val.trim();
            },
            autofocus: true,
            focusNode: _usernameFocus,
            onFieldSubmit: (val) =>
                {FocusScope.of(context).requestFocus(_firstNameFocus)},
          ),
          TextFormFieldValidation(
            label: "First Name",
            validator: (String arg) {
              if (arg.length < 3)
                return 'Name must be more than 3 character';
              else
                return null;
            },
            onValueChanged: (val) {
              _student.firstName = val.trim();
              ;
            },
            focusNode: _firstNameFocus,
            onFieldSubmit: (val) =>
                {FocusScope.of(context).requestFocus(_lastNameFocus)},
          ),
          TextFormFieldValidation(
            label: "Last Name",
            validator: (String arg) {
              if (arg.length < 3)
                return 'Name must be more than 3 character';
              else
                return null;
            },
            onValueChanged: (val) {
              _student.lastName = val.trim();
            },
            focusNode: _lastNameFocus,
            onFieldSubmit: (val) =>
                {FocusScope.of(context).requestFocus(_dobFocus)},
          ),
          CustomDatePickerFormValidation(
            focusNode: _dobFocus,
            initialDate: DateTime(1997, 09, 25),
            label: "Date of Birth",
            isBirthday: true,
            initialYear: true,
            onChange: (dateTime) {
              _student.dob = DateFormat("yyyy-MM-dd").format(dateTime);
            },
            onFieldSubmit: () =>
                {FocusScope.of(context).requestFocus(_bloodFocus)},
          ),
          DropDownFieldValidation(
            items: [
              const Item(label: "A+", value: "APOS"),
              const Item(label: "A-", value: "ANEG"),
              const Item(label: "B+", value: "BPOS"),
              const Item(label: "B-", value: "BNEG"),
              const Item(label: "AB+", value: "ABPOS"),
              const Item(label: "AB-", value: "ABNEG"),
              const Item(label: "O+", value: "OPOS"),
              const Item(label: "O-", value: "ONEG"),
            ],
            label: "Blood Group",
            prefixIcon: Icons.local_hospital,
            onValueChanged: (val) {
              _student.blood = val.trim();
            },
            focusNode: _bloodFocus,
            onFieldSubmit: () =>
                {FocusScope.of(context).requestFocus(_genderFocus)},
          ),
          DropDownFieldValidation(
            items: [
              const Item(label: "Male", value: "MALE"),
              const Item(label: "Female", value: "FEMALE"),
              const Item(label: "Transgender", value: "TRANSGENDER"),
            ],
            label: "Gender",
            prefixIcon: Icons.supervised_user_circle,
            onValueChanged: (val) {
              _student.gender = val.trim();
            },
            focusNode: _genderFocus,
            onFieldSubmit: () =>
                {FocusScope.of(context).requestFocus(_phoneFocus)},
          ),
          TextFormFieldValidation(
            label: "Phone",
            prefixIcon: Icons.phone,
            textInputFormatter: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(13)
            ],
            keyboardType: TextInputType.numberWithOptions(signed: true),
            onValueChanged: (val) {
              _student.phone = val.trim();
            },
            validator: (value) => Validator.validateMobile(value),
            focusNode: _phoneFocus,
            onFieldSubmit: (val) =>
                {FocusScope.of(context).requestFocus(_emailFocus)},
          ),
          TextFormFieldValidation(
            label: "Email",
            prefixIcon: Icons.alternate_email,
            onValueChanged: (val) {
              _student.email = val.trim();
            },
            keyboardType: TextInputType.emailAddress,
            validator: (value) => Validator.validateEmail(value),
            focusNode: _emailFocus,
            onFieldSubmit: (val) =>
                {FocusScope.of(context).requestFocus(_aadharFocus)},
          ),
          TextFormFieldValidation(
            label: "Aadhar",
            prefixIcon: Icons.contacts,
            validator: (val) {
              try {
                int.parse(val);
                if (val.length < 12) {
                  return "Aadhar number is 12 digits long";
                } else {
                  return null;
                }
              } catch (e) {
                return "Only digits allowed";
              }
            },
            onValueChanged: (val) {
              _student.aadhar = int.tryParse(val.trim());
            },
            focusNode: _aadharFocus,
            onFieldSubmit: (val) =>
                {FocusScope.of(context).requestFocus(_religionFocus)},
          ),
          DropDownFieldValidation(
            items: [
              const Item(label: "Hinduism", value: "HINDUISM"),
              const Item(label: "Islam", value: "ISLAM"),
              const Item(label: "Christianity", value: "CHRISTIANITY"),
              const Item(label: "Sikhism", value: "SIKHISM"),
              const Item(label: "Jainism", value: "JAINISM"),
              const Item(label: "Zoroastrianism", value: "ZOROASTRIANISM"),
              const Item(label: "Atheist", value: "ATHEIST"),
              const Item(label: "Others", value: "OTHERS"),
            ],
            label: "Religion",
            prefixIcon: Icons.spa,
            onValueChanged: (val) {
              _student.religion = val.trim();
            },
            focusNode: _religionFocus,
            onFieldSubmit: () =>
                {FocusScope.of(context).requestFocus(_categoryFocus)},
          ),
          DropDownFieldValidation(
            items: [
              const Item(label: "General", value: "GENERAL"),
              const Item(label: "Freedom Fighters", value: "FF"),
              const Item(label: "Backward caste group A", value: "BCA"),
              const Item(label: "Backward caste group B", value: "BCB"),
              const Item(label: "Scheduled Tribe", value: "ST"),
              const Item(label: "Scheduled Caste", value: "SC"),
              const Item(label: "Other backward caste", value: "OBC"),
            ],
            label: "category",
            prefixIcon: Icons.group_work,
            onValueChanged: (val) {
              _student.category = val.trim();
            },
            focusNode: _categoryFocus,
            onFieldSubmit: () =>
                {FocusScope.of(context).requestFocus(_nationality)},
          ),
          TextFormFieldValidation(
            label: "Nationality",
            validator: (String arg) {
              if (arg.length < 3)
                return 'Country name must be more than 3 character';
              else
                return null;
            },
            prefixIcon: Icons.map,
            onValueChanged: (val) {
              _student.nationality = val.trim().toUpperCase();
            },
            focusNode: _nationality,
            onFieldSubmit: (val) =>
                {FocusScope.of(context).requestFocus(_fatherNameFocus)},
          ),
        ],
      ),
    );
  }

  Widget _familyDetails(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: Color.fromRGBO(32, 32, 32, 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Family Details",
              style: TextStyle(
                fontSize: 22,
                color: Color(0xFFFD3664),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Text(
            "Father's Details",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          TextFormFieldValidation(
            label: "Father's Name",
            validator: (String arg) {
              if (arg.length < 6)
                return 'Name must be more than 6 character';
              else
                return null;
            },
            onValueChanged: (val) {
              _student.fathersName = val.trim();
            },
            focusNode: _fatherNameFocus,
            onFieldSubmit: (val) =>
                {FocusScope.of(context).requestFocus(_fatherPhoneFocus)},
          ),
          TextFormFieldValidation(
            label: "Father's Phone",
            textInputFormatter: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(13)
            ],
            keyboardType:
                TextInputType.numberWithOptions(signed: true, decimal: false),
            onValueChanged: (val) {
              _student.fathersPhone = val.trim();
            },
            validator: (value) => Validator.validateMobile(value),
            focusNode: _fatherPhoneFocus,
            onFieldSubmit: (val) =>
                {FocusScope.of(context).requestFocus(_fatherOccupationFocus)},
          ),
          TextFormFieldValidation(
            label: "Father's Occupation",
            validator: (String arg) {
              if (arg.length < 3)
                return 'Must be more than 3 character';
              else
                return null;
            },
            onValueChanged: (val) {
              _student.fathersOccupation = val.trim();
            },
            focusNode: _fatherOccupationFocus,
            onFieldSubmit: (val) =>
                {FocusScope.of(context).requestFocus(_fatherIncomeFocus)},
          ),
          TextFormFieldValidation(
            label: "Father's Income",
            onValueChanged: (val) {
              _student.fathersIncome = int.tryParse(val.trim());
            },
            keyboardType:
                TextInputType.numberWithOptions(signed: false, decimal: true),
            focusNode: _fatherIncomeFocus,
            onFieldSubmit: (val) =>
                {FocusScope.of(context).requestFocus(_motherNameFocus)},
          ),
          SizedBox(height: 9),
          Text(
            "Mother's Details",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          TextFormFieldValidation(
            label: "Mother's Name",
            validator: (String arg) {
              if (arg.length < 3)
                return 'Must be more than 3 character';
              else
                return null;
            },
            onValueChanged: (val) {
              _student.mothersName = val.trim();
            },
            focusNode: _motherNameFocus,
            onFieldSubmit: (val) =>
                {FocusScope.of(context).requestFocus(_motherPhoneFocus)},
          ),
          TextFormFieldValidation(
            label: "Mother's Phone",
            onValueChanged: (val) {
              _student.mothersPhone = val.trim();
            },
            keyboardType:
                TextInputType.numberWithOptions(signed: false, decimal: false),
            validator: (value) => Validator.validateMobile(value),
            focusNode: _motherPhoneFocus,
            onFieldSubmit: (val) =>
                {FocusScope.of(context).requestFocus(_motherOccupationFocus)},
          ),
          TextFormFieldValidation(
            label: "Mother's Occupation",
            onValueChanged: (val) {
              _student.mothersOccupation = val.trim();
            },
            focusNode: _motherOccupationFocus,
            onFieldSubmit: (val) =>
                {FocusScope.of(context).requestFocus(_motherIncomeFocus)},
          ),
          TextFormFieldValidation(
            label: "Mother's Income",
            onValueChanged: (val) {
              _student.mothersIncome = int.tryParse(val.trim());
            },
            keyboardType:
                TextInputType.numberWithOptions(signed: false, decimal: true),
            focusNode: _motherIncomeFocus,
            onFieldSubmit: (val) {
              setState(() {
                _familyIncome = _student.mothersIncome + _student.fathersIncome;
              });
              FocusScope.of(context).requestFocus(_familyIncomeFocus);
            },
          ),
          TextFormFieldValidation(
            label: "Family's Income",
            onValueChanged: (val) {
              _student.familyIncome = int.tryParse(val.trim());
            },
            initialValue: _familyIncome.toString(),
            keyboardType:
                TextInputType.numberWithOptions(signed: false, decimal: true),
            focusNode: _familyIncomeFocus,
            onFieldSubmit: (val) =>
                {FocusScope.of(context).requestFocus(_localAddressFocus)},
          ),
        ],
      ),
    );
  }

  Widget _addressDetails(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: Color.fromRGBO(32, 32, 32, 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Address",
              style: TextStyle(
                fontSize: 22,
                color: Color(0xFFFD3664),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            height: 9,
          ),
          TextFormFieldValidation(
            label: "Local Address",
            validator: (String arg) {
              if (arg.length < 5)
                return 'Must be more than 5 character';
              else
                return null;
            },
            onValueChanged: (val) {
              _student.localAddress = val.trim();
            },
            focusNode: _localAddressFocus,
            onFieldSubmit: (val) =>
                {FocusScope.of(context).requestFocus(_addressFocus)},
          ),
          SizedBox(height: 9),
          Text(
            "permanent Address",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          TextFormFieldValidation(
            label: "Address Line 1",
            onValueChanged: (val) {
              _student.address = val.trim();
            },
            focusNode: _addressFocus,
            onFieldSubmit: (val) =>
                {FocusScope.of(context).requestFocus(_cityFocus)},
          ),
          TextFormFieldValidation(
            label: "City",
            onValueChanged: (val) {
              _student.city = val.trim();
            },
            focusNode: _cityFocus,
            onFieldSubmit: (val) =>
                {FocusScope.of(context).requestFocus(_stateFocus)},
          ),
          TextFormFieldValidation(
            label: "State",
            onValueChanged: (val) {
              _student.state = val.trim();
            },
            focusNode: _stateFocus,
            onFieldSubmit: (val) =>
                {FocusScope.of(context).requestFocus(_pinCodeFocus)},
          ),
          TextFormFieldValidation(
            label: "PinCode",
            keyboardType:
                TextInputType.numberWithOptions(signed: false, decimal: false),
            onValueChanged: (val) {
              _student.pinCode = int.tryParse(val.trim());
            },
            validator: (String val) {
              try {
                int.parse(val);
                return null;
              } catch (e) {
                return "Only digits allowed";
              }
            },
            focusNode: _pinCodeFocus,
            onFieldSubmit: (val) =>
                {FocusScope.of(context).requestFocus(_countryFocus)},
          ),
          TextFormFieldValidation(
            label: "Country",
            onValueChanged: (val) {
              _student.country = val.trim();
            },
            focusNode: _countryFocus,
          ),
        ],
      ),
    );
  }

//FocusNode
  //personal details
  final _usernameFocus = FocusNode();
  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _dobFocus = FocusNode();
  final _bloodFocus = FocusNode();
  final _genderFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _aadharFocus = FocusNode();
  final _religionFocus = FocusNode();
  final _categoryFocus = FocusNode();
  final _nationality = FocusNode();

  //family details
  final _fatherNameFocus = FocusNode();
  final _fatherOccupationFocus = FocusNode();
  final _fatherIncomeFocus = FocusNode();
  final _fatherPhoneFocus = FocusNode();
  final _motherNameFocus = FocusNode();
  final _motherPhoneFocus = FocusNode();
  final _motherOccupationFocus = FocusNode();
  final _motherIncomeFocus = FocusNode();
  final _familyIncomeFocus = FocusNode();

  //Address
  final _localAddressFocus = FocusNode();
  final _addressFocus = FocusNode();
  final _cityFocus = FocusNode();
  final _stateFocus = FocusNode();
  final _pinCodeFocus = FocusNode();
  final _countryFocus = FocusNode();

//Controller
  //FIXME use controller on data submit
  final _usernameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _bloodController = TextEditingController();
  final _genderController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _aadharController = TextEditingController();
  final _religionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _nationalityController = TextEditingController();

  final _fatherNameController = TextEditingController();
  final _fatherOccupationController = TextEditingController();
  final _fatherIncomeController = TextEditingController();
  final _fatherPhoneController = TextEditingController();
  final _motherNameController = TextEditingController();
  final _motherPhoneController = TextEditingController();
  final _motherOccupationController = TextEditingController();
  final _motherIncomeController = TextEditingController();
  final _familyIncomeController = TextEditingController();

  final _localAddressController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _countryController = TextEditingController();

  @override
  void dispose() {
    _usernameFocus.dispose();
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _dobFocus.dispose();
    _bloodFocus.dispose();
    _genderFocus.dispose();
    _phoneFocus.dispose();
    _emailFocus.dispose();
    _aadharFocus.dispose();
    _religionFocus.dispose();
    _categoryFocus.dispose();
    _nationality.dispose();

    _fatherNameFocus.dispose();
    _fatherOccupationFocus.dispose();
    _fatherIncomeFocus.dispose();
    _fatherPhoneFocus.dispose();
    _motherNameFocus.dispose();
    _motherPhoneFocus.dispose();
    _motherOccupationFocus.dispose();
    _motherIncomeFocus.dispose();
    _familyIncomeFocus.dispose();

    _localAddressFocus.dispose();
    _addressFocus.dispose();
    _cityFocus.dispose();
    _stateFocus.dispose();
    _pinCodeFocus.dispose();
    _countryFocus.dispose();

    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _bloodController.dispose();
    _genderController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _aadharController.dispose();
    _religionController.dispose();
    _categoryController.dispose();
    _nationalityController.dispose();

    _fatherNameController.dispose();
    _fatherOccupationController.dispose();
    _fatherIncomeController.dispose();
    _fatherPhoneController.dispose();
    _motherNameController.dispose();
    _motherPhoneController.dispose();
    _motherOccupationController.dispose();
    _motherIncomeController.dispose();
    _familyIncomeController.dispose();

    _localAddressController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pinCodeController.dispose();
    _countryController.dispose();

    super.dispose();
  }
}
