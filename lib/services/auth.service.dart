import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ums_flutter/api/auth.dart';

final storage = FlutterSecureStorage();

class AuthService{
  Future<bool> login(String usernameOrEmail, String password) async {
    var body = {
      usernameOrEmail: usernameOrEmail,
      password: "password"
    };
    var response = await api(body,"login");

    if (response.statusCode ==200){
      var token = json.decode(response.body).accessToken;
      await storage.write(key: "token", value: token);
      return true;
    }
    else {
      print(json.decode(response.body).message);
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    var token = await storage.read(key: "token");
    if (token!=null){
      var response = await http.get("https://157a7637.ngrok.io/actuator/health",
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200)
      return true;
    else
      return false;
    }
    return false;
  }

  // Logout
  Future<void> logout() async {
    await storage.delete(key: "token");
  }
}