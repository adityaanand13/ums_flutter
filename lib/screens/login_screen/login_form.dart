import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/login_bloc.dart';
import 'package:ums_flutter/event_state/login/login_event.dart';
import 'package:ums_flutter/event_state/login/login_state.dart';
import 'package:ums_flutter/utils/sizeConfig.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameOrEmailController =
  TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _usernameOrEmailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
     _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          usernameOrEmail: _usernameOrEmailController.text,
          password: _passwordController.text,
        ),
      );
    }

    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginFailure) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('${state.error}'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Form(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _usernameOrEmailController,
              style: TextStyle(
                color: Colors.grey,
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              focusNode: _usernameOrEmailFocus,
              onFieldSubmitted: (term){
                _fieldFocusChange(context, _usernameOrEmailFocus, _passwordFocus);
              },
              decoration: InputDecoration(
                  labelText: 'USERNAME OR EMAIL',
                  labelStyle: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green))),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2.5),
            TextFormField(
              controller: _passwordController,
              textInputAction: TextInputAction.done,
              style: TextStyle(
                color: Colors.grey,
              ),
              focusNode: _passwordFocus,
              onFieldSubmitted: (value){
                _passwordFocus.unfocus();
                _onLoginButtonPressed();
              },
              decoration: InputDecoration(
                  labelText: 'PASSWORD',
                  labelStyle: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green))),
              obscureText: true,
            ),
            SizedBox(height: SizeConfig.blockSizeVertical),
            Container(
              alignment: Alignment(1.0, 0.0),
              padding: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 2.5,
                  left: SizeConfig.blockSizeHorizontal * 2.5),
              child: InkWell(
                child: Text(
                  'Forgot Password',
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      decoration: TextDecoration.underline),
                ),
              ),
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
                  onTap: state is! LoginLoading ? _onLoginButtonPressed : null,
                  child: Center(
                    child: Text(
                      'SUBMIT',
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 5,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: state is LoginLoading ? CircularProgressIndicator() : null,
            ),
          ],
        ),
      );
    }));
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
