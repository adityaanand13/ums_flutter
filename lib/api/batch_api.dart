//todo declare user profile get function

//todo declare user profile update function

import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert' show json;

import 'package:ums_flutter/exception/CustomException.dart';
import 'package:ums_flutter/utils/constants.dart';

class BatchApiProvider{
  static const _BASE_URL = "$BASE_URL/api/batch";

  Future<dynamic>  get(String route, String token) async{
    var responseJson;
    var headers = {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $token'
    };
    try{
      var response = await http.get("$_BASE_URL/$route", headers: headers);
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
      final response = await http.post("$_BASE_URL/$route", headers: headers, body: body);
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
      final response = await http.post("$_BASE_URL/$route", headers: headers, body: body);
      responseJson = _response(response);
    }on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  //todo move to separate class
  //returns json
  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson['data'];
      case 400:
        var responseJson = json.decode(response.body)['error'];
        throw BadRequestException(responseJson);
      case 404:
        print(response.body);
        var responseJson = json.decode(response.body)['error'];
        throw NotFoundException(responseJson);
      case 401:
      case 403:
        var responseJson = json.decode(response.body)['error'];
        throw UnauthorisedException(responseJson);
      case 500:
      default:
        print(response.body);
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  delete(String s, String token) {}
}