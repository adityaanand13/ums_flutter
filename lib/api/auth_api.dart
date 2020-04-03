import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert' show ascii, base64, json, jsonEncode;

import 'package:ums_flutter/exception/CustomException.dart';

class AuthApiProvider{

  static const _BASE_URI = "http://localhost:8080/api/auth";
  static const _headers = {"Content-Type": "application/json"};

//api
  Future<dynamic> post(var body, String route) async {
    var responseJson;
    body = json.encode(body);
    try{
      final response = await http.post("$_BASE_URI/$route", headers: _headers, body: body);
      responseJson = _response(response);
    }on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
  
  Future<bool> get(String route, String token) async{
    var headers = {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $token'
    };
    try{
      final response = await http.get("$_BASE_URI/$route", headers: headers);
      return response.statusCode == 200;
    }on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return false;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
