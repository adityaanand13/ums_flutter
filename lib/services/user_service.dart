
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ums_flutter/api/user_api.dart';
import 'package:ums_flutter/models/user_model.dart';

class UserService {
  UserApiProvider _provider = UserApiProvider();
  FlutterSecureStorage _storage = new FlutterSecureStorage();

  Future<UserModel> getUser() async {
    var userJson = await _storage.read(key: 'user');
    var user = UserModel.fromJsonMap(json.decode(userJson));
    return user;
  }

  Future<UserModel> fetchUser() async {
    String token = await _storage.read(key: "token");
    var userJson = await _provider.getUser("", token);
    UserModel userModel = UserModel.fromJsonMap(userJson);
    return userModel;
  }

  Future<void> deleteUser() async {
    await _storage.delete(key: "user");
    return;
  }

  Future<void> persistUser(UserModel userModel) async {
    await _storage.write(key: 'user', value: json.encode(userModel.toJson()));
    return;
  }

  Future<bool> hasUser()  async {
    var user = await _storage.read(key: "user");
    if(user!=null){
      return true;
    } else {
      return false;
    }
  }
  
}


//    userModel.id = (await _storage.read(key: 'id')) as int;
//    userModel.username = await _storage.read(key: 'username');
//    userModel.firstName = await _storage.read(key: 'firstName');
//    userModel.lastName = await _storage.read(key: 'lastName');
//    userModel.email = await _storage.read(key: 'email');
//    userModel.gender = await _storage.read(key: 'gender');
//    userModel.phone = await _storage.read(key: 'phone');
//    userModel.blood = await _storage.read(key: 'blood');
//    userModel.religion = await _storage.read(key: 'religion');
//    userModel.category = await _storage.read(key: 'category');
//    userModel.aadhar = (await _storage.read(key: 'aadhar')) as int;
//    userModel.userType = await _storage.read(key: 'userType');
//    userModel.address = await _storage.read(key: 'address');
//    userModel.city = await _storage.read(key: 'city');
//    userModel.state = await _storage.read(key: 'state');
//    userModel.pinCode = (await _storage.read(key: 'pinCode')) as int;
//    userModel.country = await _storage.read(key: 'country');
//    userModel.dob = await _storage.read(key: 'dob');