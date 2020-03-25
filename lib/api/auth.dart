import 'package:http/http.dart' as http;
import 'dart:convert' show json, base64, ascii;

//todo declare api base url
const BASE_URI = "http://127.0.0.1:8080/api/auth";

//login api
Future<http.Response> attemptLogIn(String username, String password) async {
  var data = {
    "usernameOrEmail": username,
    "password": password
  };
  var body = json.encode(data);
  var response = await http.post(
      "$BASE_URI/login",
      headers: {"Content-Type": "application/json"},
      body:body
  );
  //todo if statuscode == 200 save the token to database for future login
  //flutter: {
  //  "accessToken":"eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxIiwiaWF0IjoxNTg1MDU3MDA0LCJleHAiOjE1ODU2NjE4MDR9.U4yP39m6btblXMrDd3EZBnAOqYULcJyg_w1sdk5W1XpBaCtahTPauxJvGhty8NS227SAzglxF3_9q0xB0QjpHQ",
  //  "tokenType":"Bearer"}

  return response;
}

//signup api
//todo add signup variable
Future<http.Response> attemptSignUp(String username, String password) async {
  var response = await http.post(
      '$BASE_URI/signup',
      body: {
        "username": username,
        "password": password
      }
  );
  return response;
}

//todo declare logout fucntion

//todo fetch token from database function