import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ums_flutter/components/components.dart';
import 'package:ums_flutter/components/input/drop_down_field_validation.dart';
import 'package:ums_flutter/models/models.dart';
import 'package:ums_flutter/utils/utils.dart';
import 'package:ums_flutter/validator/validator.dart';

class AddStudentScreen extends StatefulWidget {
  final SideDrawer sideDrawer;

  const AddStudentScreen({Key key, @required this.sideDrawer})
      : super(key: key);

  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formsPageViewController = PageController();
  GlobalKey _formKey;
  Student _student;
  bool isActive;
  int currentStep;
  bool complete = false;

  @override
  void initState() {
    _formKey = GlobalKey();
    _student = Student();
    isActive = false;
    currentStep = 0;
    complete = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: widget.sideDrawer,
      bottomNavigationBar: CustomBottomNavigationBar(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.cancel,
          color: Colors.red,
        ),
      ),
      body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: SIDE_MARGIN),
                child: PageHeader(line1: "Add", line2: "Student"),
              ),
              Form(
                key: _formKey,
                child: _steps(context),
              ),
            ],
          )),
    );
  }

  next() {
    currentStep + 1 != 3
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  Widget _steps(BuildContext context) {
    return Expanded(
      child: Container(
        color: Color(0xFF0D0D0D),
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: currentStep,
          onStepContinue: next,
          onStepTapped: (step) => goTo(step),
          onStepCancel: cancel,
          steps: [
            Step(
              title: Text(
                "Personal Details",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFFD3664),
                  fontWeight: FontWeight.w400,
                ),
              ),
              isActive: false,
              content: _personalDetails(context),
            ),
            Step(
              title: Text(
                "Family Details",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFFD3664),
                  fontWeight: FontWeight.w400,
                ),
              ),
              content: _familyDetails(context),
            ),
            Step(
              state: StepState.editing,
              title: Text(
                "Address",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFFD3664),
                  fontWeight: FontWeight.w400,
                ),
              ),
              content: _addressDetails(context),
            )
          ],
        ),
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
          CustomDatePicker(
            label: "Date of Birth",
            isBirthday: true,
            initialYear: true,
            onChange: (dateTime) {
              print(dateTime.toIso8601String());
              _student.dob = dateTime.toIso8601String();
            },
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
            onFieldSubmit: (val) =>
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
            onFieldSubmit: (val) =>
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
              _student.lastName = val.trim();
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
            onFieldSubmit: (val) =>
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
            autofocus: true,
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
              _student.phone = val.trim();
            },
            validator: (value) => Validator.validateMobile(value),
            focusNode: _fatherPhoneFocus,
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
            {FocusScope.of(context).requestFocus(_motherPhoneFocus)},
          ),
          TextFormFieldValidation(
            label: "Mother's Phone",
            onValueChanged: (val) {
              _student.lastName = val.trim();
            },
            keyboardType:
            TextInputType.numberWithOptions(signed: false, decimal: false),
            validator: (value) => Validator.validateMobile(value),
            focusNode: _motherPhoneFocus,
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
            autofocus: true,
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

  _onCreateButtonPressed(BuildContext context) {}

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

  //family details
  final _fatherNameFocus = FocusNode();
  final _fatherOccupationFocus = FocusNode();
  final _fatherIncomeFocus = FocusNode();
  final _fatherPhoneFocus = FocusNode();
  final _motherNameFocus = FocusNode();
  final _motherPhoneFocus = FocusNode();
  final _motherOccupationFocus = FocusNode();
  final _motherIncomeFocus = FocusNode();

  //Address
  final _localAddressFocus = FocusNode();
  final _addressFocus = FocusNode();
  final _cityFocus = FocusNode();
  final _stateFocus = FocusNode();
  final _pinCodeFocus = FocusNode();
  final _countryFocus = FocusNode();
}
