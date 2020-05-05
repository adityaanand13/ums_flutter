
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ums_flutter/api/Instructor_api.dart';
import 'package:ums_flutter/models/instructor_model.dart';

class InstructorService {
  InstructorApiProvider _provider = InstructorApiProvider();
  FlutterSecureStorage _storage = new FlutterSecureStorage();

  Future<InstructorModel> getInstructor(String username) async {
    String token = await _storage.read(key: "token");
    var instructorJson = await _provider.getInstructor("", token);
    InstructorModel instructorModel = InstructorModel.fromJsonMap(instructorJson);
    return instructorModel;
  }

//  Future<void> deleteInstructor() async {
//    await _storage.delete(key: "user");
//    return;
//  }

  Future<InstructorModel> addInstructor(InstructorModel instructorModel) async {
    String token = await _storage.read(key: "token");
    var instructorJson = await _provider.post(instructorModel.toJson(),"", token);
    print("hello");
    print(instructorJson);
    var instructorResponse = InstructorModel.fromJsonMap(instructorJson);
    return instructorResponse;
  }
}