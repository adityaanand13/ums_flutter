import 'package:http/http.dart' as http;
import 'dart:convert' show json, base64, ascii;

//todo declare api base url
const BASE_URI = "http://13.233.74.229:8080/api/auth";

//todo declare login function uri+
Future<int> attemptLogIn(String username, String password) async {
  var data = {
    "usernameOrEmail": username,
    "password": password
  };
  var body = json.encode(data);
  var res = await http.post(
      "$BASE_URI/login",
      headers: {"Content-Type": "application/json"},
      body:body
  );
  print(res.body);
  //todo if statuscode == 200 save the token to database for future login
  //flutter: {
  //  "accessToken":"eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxIiwiaWF0IjoxNTg1MDU3MDA0LCJleHAiOjE1ODU2NjE4MDR9.U4yP39m6btblXMrDd3EZBnAOqYULcJyg_w1sdk5W1XpBaCtahTPauxJvGhty8NS227SAzglxF3_9q0xB0QjpHQ",
  //  "tokenType":"Bearer"}

  return res.statusCode;
}

//todo declare sigup fucntion
Future<int> attemptSignUp(String username, String password) async {
  var res = await http.post(
      '$BASE_URI/signup',
      body: {
        "username": username,
        "password": password
      }
  );
  return res.statusCode;
}

//todo declare logout fucntion

//todo fetch token from database function