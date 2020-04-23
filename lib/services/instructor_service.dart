
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ums_flutter/api/Instructor_api.dart';
import 'package:ums_flutter/api/user_api.dart';
import 'package:ums_flutter/models/user_model.dart';

class InstructorService {
  InstructorApiProvider _provider = InstructorApiProvider();
  FlutterSecureStorage _storage = new FlutterSecureStorage();

  Future<UserModel> getInstructor() async {
    var userJson = await _storage.read(key: 'user');
    var user = UserModel.fromJsonMap(json.decode(userJson));
    return user;
  }

  Future<UserModel> fetchInstructor() async {
    String token = await _storage.read(key: "token");
    var userJson = await _provider.getInstructor("", token);
    UserModel userModel = UserModel.fromJsonMap(userJson);
    return userModel;
  }

  Future<void> deleteInstructor() async {
    await _storage.delete(key: "user");
    return;
  }

  Future<void> persistInstructor(UserModel userModel) async {
    await _storage.write(key: 'user', value: json.encode(userModel.toJson()));
    return;
  }
}