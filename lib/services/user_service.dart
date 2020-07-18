import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:ums_flutter/api/api.dart';
import 'package:ums_flutter/models/models.dart';
import 'package:ums_flutter/utils/utils.dart';

class UserService {
  final ServerApiProvider serverApiProvider;
  final StorageApiProvider storageApiProvider;

  UserService({@required this.serverApiProvider, @required this.storageApiProvider});

  final String _baseUrl = USER_URL;

  Future<UserModel> getUser() async {
    var userJson = await storageApiProvider.readValue(key: 'user');
    var user = UserModel.fromJsonMap(json.decode(userJson));
    return user;
  }

  Future<UserModel> fetchUser() async {
    String token = await storageApiProvider.getToken();
    var userJson = await serverApiProvider.get(route: "$_baseUrl/", token: token);
    UserModel userModel = UserModel.fromJsonMap(userJson);
    return userModel;
  }

  Future<bool> deleteUser() async {
    try {
      await storageApiProvider.deleteValue(key: "user");
      return true;
    } catch (_) {
      print("error: ${_.toString()}");
      return false;
    }
  }

  Future<bool> persistUser(UserModel userModel) async {
    try {
      storageApiProvider.user =
          json.encode(userModel.toJson());
      return true;
    } catch (_) {
      print("error: ${_.toString()}");
      return false;
    }
  }

  Future<bool> hasUser() async {
    try {
      var user = await storageApiProvider.getUser();
      if (user != null) {
        return true;
      } else {
        return false;
      }
    } catch (_) {
      print("error: ${_.toString()}");
      return false;
    }
  }
}
