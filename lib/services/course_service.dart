import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ums_flutter/api/college_api.dart';
import 'package:ums_flutter/api/course_api.dart';
import 'package:ums_flutter/models/request/course_request.dart';
import 'package:ums_flutter/models/response/college_response.dart';
import 'package:ums_flutter/models/response/course_response.dart';

class CourseService {
  CourseApiProvider _provider = CourseApiProvider();
  CollegeApiProvider _collegeApiProvider = CollegeApiProvider();
  FlutterSecureStorage _storage = new FlutterSecureStorage();

  //todo refactor
  Future<CollegeResponse> addCourse({int collegeID, CourseRequest courseRequest}) async {
    String token = await _storage.read(key: "token");
    var collegeJson = await _collegeApiProvider.post(courseRequest.toJson(), "$collegeID/add-course", token);
    var collegeResponse = CollegeResponse.fromJsonMap(collegeJson);
    return collegeResponse;
  }

  Future<CourseResponse> getCourse(int id) async {
    String token = await _storage.read(key: "token");
    var courseJson = await _provider.get("$id", token);
    var courseResponse = CourseResponse.fromJsonMap(courseJson);
    return courseResponse;
  }

  Future<bool> deleteCourse(int id) async {
    //todo refactor return
    String token = await _storage.read(key: "token");
    var collegeJson = await _provider.delete("$id", token);
    return true;
  }

  Future<CourseResponse> updateCourse(CourseRequest courseRequest) async {
    String token = await _storage.read(key: "token");
    var courseJson = await _provider.put(courseRequest.toJson(), "", token);
    var courseResponse = CourseResponse.fromJsonMap(courseJson);
    return courseResponse;
  }

//  Future<CollegeResponse> addBatch({int collegeID, CourseResponse courseResponse}) async {
//    String token = await _storage.read(key: "token");
//    var collegeJson = await _provider.post(courseResponse.toJson(), "$collegeID/add-course", token);
//    var collegeResponse = CollegeResponse.fromJsonMap(collegeJson);
//    return collegeResponse;
//  }

}