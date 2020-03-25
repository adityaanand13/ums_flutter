import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import '../api/auth.dart';
import '../main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json, base64, ascii;
import 'package:email_validator/email_validator.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}
class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}

class _SignupPageState extends State<SignupPage> {
  DateTime _selectedDate;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();


  void displayDialog(context, title, text) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
                title: Text(title),
                content: Text(text)
            ),
      );

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return null;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new SafeArea(
            top: false,
            bottom: false,
            child: new Form(
                key: _formKey,
                autovalidate: true,
                child: new ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(60.0, 110.0, 0.0, 0.0),
                      child: Text('Sign-Up',
                        style: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    new TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.person_outline),
                        hintText: 'Enter Your Roll No./Employee ID',
                        labelText: 'USERNAME',
                      ),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                    ),
                    new TextFormField(
                      controller: _firstnameController,
                      decoration: const InputDecoration(
                          icon: const Icon(Icons.person),
                          hintText: 'Enter Your First and Last name',
                          labelText: 'Full Name'
                      ),
                    ),
                    new TextFormField(
                      controller: _lastnameController,
                      decoration: const InputDecoration(
                          icon: const Icon(Icons.person),
                          hintText: 'Enter Last name',
                          labelText: 'Last Name'
                      ),
                    ),
                    Container(
                      height: 70,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(_selectedDate == null
                                  ? 'No Date Chosen'
                                  : 'picked date : ${DateFormat.yMd().format(_selectedDate)}')),
                          FlatButton(
                            child: Text(
                              'Choose Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: _datePicker,
                            textColor: Theme.of(context).primaryColor,
                          )
                        ],
                      ),
                    ),
                    new TextFormField(
                      controller: _dobController,
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.calendar_today),
                        hintText: 'Enter your date of birth',
                        labelText: 'Dob',
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                    new TextFormField(
                      controller: _genderController,
                      decoration: const InputDecoration(
                          icon: const Icon(Icons.person),
                          hintText: 'Male/Female',
                          labelText: 'Gender'
                      ),
                    ),
                    new TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.phone),
                        hintText: 'Enter a phone number',
                        labelText: 'Phone',
                      ),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                    ),
                    new TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.email),
                        hintText: 'Enter a email address',
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          icon: const Icon(Icons.security),
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
                            var username  = _usernameController.text;
                            var firstname = _firstnameController.text;
                            var lastname  = _lastnameController.text;
                            var dob       = _dobController.text;
                            var phone     = _phoneController.text;
                            var email     = _emailController.text;
                            var password  = _passwordController.text;

                            if (username.length < 4)
                              displayDialog(context, "Invalid Username",
                                  "The username should be at least 4 characters long");
                            else if (password.length < 4)
                              displayDialog(context, "Invalid Password",
                                  "The password should be at least 4 characters long");
                            else if (phone.length < 10)
                              displayDialog(context, "Invalid Password",
                                  "The password should be at least 4 characters long");
                            else if (EmailValidator.validate(email))
                              displayDialog(context, "Invalid email",
                                  "Invalid email address");
                            else {
                              var response = await attemptSignUp(username, password);
                              var status = response.statusCode;
                              if (status == 200){
                                var responseLogin = await attemptLogIn(username, password);
                                //todo change to Home page
                                Navigator.of(context).pushNamed('/home');
                              }
                              else {
                                displayDialog(context, "Error",
                                    response.body);
                              }
                            }
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
                    SizedBox(height: 20.0),
                    Container(
                      height: 40.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1.0),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/login');
                          },
                          child:
                          Center(
                            child: Text('Go Back',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat')),
                          ),
                        ),
                      ),
                    ),
                  ],
                )))
    );
  }
}