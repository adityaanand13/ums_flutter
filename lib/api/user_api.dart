//todo declare user profile get function

//todo declare user profile update function

import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert' show json;

import 'package:ums_flutter/exception/CustomException.dart';

class UserApiProvider{
  static const _BASE_URI = "http://localhost:8080/api/user";

  Future<dynamic>  getUser(String route, String token) async{
    var responseJson;
    var headers = {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $token'
    };
    try{
      var response = await http.get("$_BASE_URI/$route", headers: headers);
      responseJson = _response(response);
    }on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(var body, String route, String token) async {
    var responseJson;
    body = json.encode(body);
    var headers = {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $token'
    };
    try{
      final response = await http.post("$_BASE_URI/$route", headers: headers, body: body);
      responseJson = _response(response);
    }on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> put(var body, String route, String token) async {
    var responseJson;
    body = json.encode(body);
    var headers = {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $token'
    };
    try{
      final response = await http.post("$_BASE_URI/$route", headers: headers, body: body);
      responseJson = _response(response);
    }on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  //todo move to separate class
  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson['data'];
      case 400:
        var responseJson = json.decode(response.body)['error'];
        throw BadRequestException(responseJson);
      case 401:

      case 403:
        var responseJson = json.decode(response.body)['error'];
        throw UnauthorisedException(responseJson);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}