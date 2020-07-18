import 'package:meta/meta.dart';
import 'package:ums_flutter/api/api.dart';
import 'package:ums_flutter/exception/exception.dart';
import 'package:ums_flutter/models/models.dart';
import 'package:ums_flutter/utils/utils.dart';

class AuthService {
  final ServerApiProvider serverApiProvider;
  final StorageApiProvider storageApiProvider;
  final String _baseUrl = AUTH_URL;

  //
  AuthService(
      {@required this.serverApiProvider, @required this.storageApiProvider});

  Future<LoginResponse> login({String usernameOrEmail, String password}) async {
    LoginRequest loginRequest =
        LoginRequest(usernameOrEmail = usernameOrEmail, password = password);
    var response = await serverApiProvider.post(
        body: loginRequest.toMap(), route: "$_baseUrl/login", token: null);
    return LoginResponse.map(response);
  }

  Future<TokenStatus> checkToken() async {

    try{
      String token = await storageApiProvider.getToken();
      var data =
          await serverApiProvider.get(route: "$_baseUrl/verify", token: token);
      data = data["valid"];
      return data == true ? TokenStatus.OK : TokenStatus.UNAUTHORISED;
    } on UnauthorisedException catch(_){
      return TokenStatus.UNAUTHORISED;
    } on Exception catch(_){
      return TokenStatus.ERROR;
    }
  }

  Future<void> logout() async {
    await storageApiProvider.deleteAllValue();
    return;
  }

  Future<void> persistToken(String token) async {
    storageApiProvider.token = token;
    return;
  }

  Future<bool> hasToken() async {
    var token = await storageApiProvider.getToken();
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }
}
