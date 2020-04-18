import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ums_flutter/bloc/navigation/navigation_bloc.dart';
import 'package:ums_flutter/utils/sizeConfig.dart';

class AddTutor extends StatefulWidget with NavigationStates {
  @override
  _AddTutorState createState() => _AddTutorState();
}

class _AddTutorState extends State<AddTutor> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _religionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pincCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(16, 16, 16, 1),
      body: Material(
        color: Color.fromRGBO(16, 16, 16, 1),
        child: SafeArea(
          bottom: true,
          child: Stack(
            children: <Widget>[
              ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.transparent])
                      .createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                //todo change image
                child: Image.asset('images/university.jpg',
                    alignment: Alignment.topCenter,
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.blockSizeVertical * 33,
                    fit: BoxFit.fill),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 230.0, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'ADD',
                          style: TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: SizeConfig.blockSizeHorizontal * 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text('Teacher',
                            style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: SizeConfig.blockSizeHorizontal * 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFD3664))),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 300),
                child: SafeArea(
                  top: true,
                  bottom: true,
                  child: new Form(
                      key: _formKey,
                      autovalidate: true,
                      child: ListView(
                        scrollDirection: Axis.vertical,
//                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        children: <Widget>[
                          new TextFormField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              icon: const Icon(Icons.person_outline,color: Colors.white),
                              hintText: 'Enter Your Roll No./Employee ID',
                              labelText: 'USERNAME',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly,
                            ],
                          ),
                          new TextFormField(
                            controller: _firstNameController,
                            decoration: const InputDecoration(
                              icon: const Icon(Icons.person,color: Colors.white),
                              hintText: 'Enter Your First and Last name',
                              labelText: 'Full Name',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                          new TextFormField(
                            controller: _lastNameController,
                            decoration: const InputDecoration(
                              icon: const Icon(Icons.person,color: Colors.white),
                              hintText: 'Enter Last name',
                              labelText: 'Last Name',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                          new TextFormField(
                            controller: _dobController,
                            decoration: const InputDecoration(
                              icon: const Icon(Icons.calendar_today,color: Colors.white),
                              hintText: 'yyyy/mm/dd',
                              labelText: 'Dob',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            keyboardType: TextInputType.datetime,
                          ),
                          new TextFormField(
                            controller: _genderController,
                            decoration: const InputDecoration(
                              icon: const Icon(Icons.person,color: Colors.white),
                              hintText: 'Male/Female',
                              labelText: 'Gender',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                          new TextFormField(
                            controller: _bloodGroupController,
                            decoration: const InputDecoration(
                              icon: const Icon(Icons.person,color: Colors.white),
                              hintText: 'B Positive',
                              labelText: 'Blood Group',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                          new TextFormField(
                            controller: _religionController,
                            decoration: const InputDecoration(
                              icon: const Icon(Icons.person,color: Colors.white),
                              hintText: 'Hindu/Muslim/Sikh',
                              labelText: 'Religion',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                          new TextFormField(
                            controller: _categoryController,
                            decoration: const InputDecoration(
                              icon: const Icon(Icons.person,color: Colors.white),
                              hintText: 'Genral/SC/OBC',
                              labelText: 'Category',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                          new TextFormField(
                            controller: _phoneController,
                            decoration: const InputDecoration(
                              icon: const Icon(Icons.phone,color: Colors.white),
                              hintText: 'Enter a phone number',
                              labelText: 'Phone',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly,
                            ],
                          ),
                          new TextFormField(
                            controller: _aadharController,
                            decoration: const InputDecoration(
                              icon: const Icon(Icons.card_membership,color: Colors.white),
                              hintText: 'Enter your aadhar number',
                              labelText: 'Aadhar',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly,
                            ],
                          ),
                          new TextFormField(
                            controller: _addressController,
                            decoration: const InputDecoration(
                              icon: const Icon(Icons.home,color: Colors.white),
                              hintText: 'House no./Flat No.',
                              labelText: 'Address',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                          new TextFormField(
                            controller: _cityController,
                            decoration: const InputDecoration(
                              icon: const Icon(Icons.location_city,color: Colors.white),
                              hintText: 'Mumbai',
                              labelText: 'City',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                          new TextFormField(
                            controller: _stateController,
                            decoration: const InputDecoration(
                              icon: const Icon(Icons.location_city,color: Colors.white),
                              hintText: 'Haryana/Punjab',
                              labelText: 'State',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                          new TextFormField(
                            controller: _pincCodeController,
                            decoration: const InputDecoration(
                              icon: const Icon(Icons.location_on,color: Colors.white),
                              hintText: '136118',
                              labelText: 'Pin Code',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                          new TextFormField(
                            controller: _countryController,
                            decoration: const InputDecoration(
                              icon: const Icon(Icons.map,color: Colors.white),
                              hintText: 'India',
                              labelText: 'Country',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                          new TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              icon: const Icon(Icons.email,color: Colors.white),
                              hintText: 'Enter a email address',
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 20.0),
                          TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                                icon: const Icon(Icons.security,color: Colors.white),
                                labelText: 'PASSWORD',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green))),
                            obscureText: true,
                          ),
                          SizedBox(height: 40.0),
                          Container(
                            height: 40.0,
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.greenAccent,
                              color: Colors.green,
                              elevation: 7.0,
                              child: GestureDetector(
                                onTap: () async {
                                  var usernameOrEmail = _usernameController.text;
                                  var firstName = _firstNameController.text;
                                  var lastName = _lastNameController.text;
                                  var dob = _dobController.text;
                                  var phone = _phoneController.text;
                                  var email = _emailController.text;
                                  var password = _passwordController.text;
                                  var gender = _genderController.text;
                                },
                                child: Center(
                                  child: Text(
                                    'SUBMIT',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat'),
                                  ),

                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20)
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
