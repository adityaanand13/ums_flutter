import 'package:ums_flutter/models/model_template.dart';

class LoginRequest extends Model{
  String _usernameOrEmail;
  String _password;

  String get usernameOrEmail => _usernameOrEmail;
  String get password => _password;

  LoginRequest(this._usernameOrEmail, this._password);

  LoginRequest.map(dynamic obj) {
    _usernameOrEmail = obj["usernameOrEmail"];
    _password = obj["password"];
  }

  @override
  Map<String, String> toMap() {
    var map = <String, String>{};
    map["usernameOrEmail"] = _usernameOrEmail;
    map["password"] = _password;
    return map;
  }

}