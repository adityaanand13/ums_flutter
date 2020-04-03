//import 'dart:async';
//import 'dart:convert';
//import 'package:http/http.dart' as http;
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:ums_flutter/api/auth_api.dart';
//
//
//final storage = FlutterSecureStorage();
//
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ums_flutter/api/auth_api.dart';
import 'package:ums_flutter/models/request/login_request.dart';
import 'package:ums_flutter/models/response/login_response.dart';

class AuthService {
  AuthApiProvider _provider = AuthApiProvider();
  FlutterSecureStorage _storage = new FlutterSecureStorage();

  Future<LoginResponse> login({String usernameOrEmail, String password}) async {
    LoginRequest loginRequest =
        LoginRequest(usernameOrEmail = usernameOrEmail, password = password);
    var response = await _provider.post(loginRequest.toMap(), "login");
    return LoginResponse.map(response);
  }

  Future<bool> checkToken() async {
    String token = await _storage.read(key: "token");
    return await _provider.get("/verify", token);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: "token");
    return;
  }

  Future<void> persistToken(String token) async {
    await _storage.write(key: 'token', value: token);
    return;
  }

  Future<bool> hasToken() async {
    var token = await _storage.read(key: "token");
    if(token!=null){
      return true;
    } else {
      return false;
    }
  }
}

//
//  Future<bool> isLoggedIn() async {
//    var token = await storage.read(key: "token");
//    if (token!=null){
//      var response = await http.get("https://157a7637.ngrok.io/actuator/health",
//          headers: {
//            'Content-Type': 'application/json',
//            'Authorization': 'Bearer $token',
//          });
//      if (response.statusCode == 200)
//        return true;
//      else
//        return false;
//    }
//    return false;
//  }
//
//  // Logout
//  Future<void> logout() async {
//    await storage.delete(key: "token");
//  }
//}
