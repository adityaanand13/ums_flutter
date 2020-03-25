import 'package:http/http.dart' as http;
import 'dart:convert' show json, base64, ascii;

//todo declare api base url
const BASE_URI = "https://157a7637.ngrok.io/api/auth";
const headers = {"Content-Type": "application/json"};

//api
Future<http.Response> api(var body, String route) async {
  body = json.encode(body);
  return await http.post("$BASE_URI/$route", headers: headers, body: body);
}