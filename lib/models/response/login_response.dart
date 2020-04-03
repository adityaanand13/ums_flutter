import 'package:ums_flutter/models/model_template.dart';

/// accessToken : "secret"
/// tokenType : "Bearer"

class LoginResponse extends Model{
  String _accessToken;
  String _tokenType;

  String get accessToken => _accessToken;
  String get tokenType => _tokenType;

  LoginResponse(this._accessToken, this._tokenType);

  LoginResponse.map(dynamic obj) {
    _accessToken = obj["accessToken"];
    _tokenType = obj["tokenType"];
  }

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["accessToken"] = _accessToken;
    map["tokenType"] = _tokenType;
    return map;
  }

}