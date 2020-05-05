import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ums_flutter/api/college_api.dart';
import 'package:ums_flutter/models/request/college_request.dart';
import 'package:ums_flutter/models/response/college_response.dart';
import 'package:ums_flutter/models/response/college_s_response.dart';
import 'package:ums_flutter/models/response/course_response.dart';

class CollegeService {
  CollegeApiProvider _provider = CollegeApiProvider();
  FlutterSecureStorage _storage = new FlutterSecureStorage();

  Future<CollegesResponse> getCollegeS() async {
    String token = await _storage.read(key: "token");
    var collegesJson = await _provider.get("", token);
    var collegesResponse = CollegesResponse.fromJsonMap(collegesJson);
    return collegesResponse;
  }

  Future<CollegeResponse> getCollege(int id) async {
    String token = await _storage.read(key: "token");
    var collegeJson = await _provider.get("$id", token);
    var collegeResponse = CollegeResponse.fromJsonMap(collegeJson);
    return collegeResponse;
  }

  Future<bool> deleteCollege(int id) async {
    //todo refactor return
    String token = await _storage.read(key: "token");
    var collegeJson = await _provider.delete("$id", token);
    return true;
  }

  Future<CollegeResponse> updateCollege(CollegeRequest collegeRequest) async {
    String token = await _storage.read(key: "token");
    var collegeJson = await _provider.put(collegeRequest.toJson(), "", token);
    var collegeResponse = CollegeResponse.fromJsonMap(collegeJson);
    return collegeResponse;
  }

  Future<CollegeResponse> createCollege(CollegeRequest collegeRequest) async {
    String token = await _storage.read(key: "token");
    var collegeJson = await _provider.post(collegeRequest.toJson(), "", token);
    var collegeResponse = CollegeResponse.fromJsonMap(collegeJson);
    return collegeResponse;
  }

  Future<CollegeResponse> addCourse({int collegeID, CourseResponse courseResponse}) async {
    String token = await _storage.read(key: "token");
    var collegeJson = await _provider.post(courseResponse.toJson(), "$collegeID/add-course", token);
    var collegeResponse = CollegeResponse.fromJsonMap(collegeJson);
    return collegeResponse;
  }

  Future<bool> addPrincipal({int collegeID, String username}) async {
    String token = await _storage.read(key: "token");
    var response = await _provider.post(null, "$collegeID/add-principal/$username", token);
    return true;
  }
}