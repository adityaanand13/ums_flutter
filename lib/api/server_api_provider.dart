import 'dart:io';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

import 'package:ums_flutter/exception/exception.dart';

class ServerApiProvider {

  ///singleton class
  static final ServerApiProvider _serverApiProvider = new ServerApiProvider._internal();

  factory ServerApiProvider() {
    return _serverApiProvider;
  }

  ServerApiProvider._internal();

  var _headers = {
    HttpHeaders.contentTypeHeader: "application/json",
  };

  Future<dynamic> get({@required String route, @required String token}) async {
    var responseJson;
    try {
      if (token != null)
        _headers.addAll({
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
      var response = await http.get(route, headers: _headers);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(
      {@required var body,
      @required String route,
      @required String token}) async {
    var responseJson;
    body = json.encode(body);
    try {
      if (token != null)
        _headers.addAll({
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
      final response =
          await http.post(route, headers: _headers, body: body);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> put(
      {@required var body,
      @required String route,
      @required String token}) async {
    var responseJson;
    body = json.encode(body);
    try {
      if (token != null)
        _headers.addAll({
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
      final response =
          await http.post(route, headers: _headers, body: body);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> patch(
      {@required var body,
        @required String route,
        @required String token}) async {
    var responseJson;
    body = json.encode(body);
    try {
      if (token != null)
        _headers.addAll({
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
      final response =
      await http.patch(route, headers: _headers, body: body);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(
      {@required String route, @required String token}) async {
    var responseJson;
    try {
      if (token != null)
        _headers.addAll({
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
      final response = await http.delete(route, headers: _headers);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

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
        var responseJson = json.decode(response.body)['error'];
        throw NotFoundException(responseJson);
      case 401:
      case 403:
        var responseJson = json.decode(response.body)['error'];
        throw UnauthorisedException(responseJson);
      case 409:
        var responseJson = json.decode(response.body)['error'];
        throw ConflictException(responseJson);
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

final serverApiProvider = ServerApiProvider();
