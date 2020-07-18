import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:ums_flutter/api/api.dart';
import 'package:ums_flutter/models/models.dart';
import 'package:ums_flutter/utils/utils.dart';

class CollegeService {
  final ServerApiProvider serverApiProvider;
  final StorageApiProvider storageApiProvider;

  final String baseUrl = COLLEGE_URL;

  CollegeService(
      {@required this.serverApiProvider, @required this.storageApiProvider});

  Future<CollegesResponse> loadCollegeS() async {
    String collegesJson = await storageApiProvider.readValue(key: "colleges");
    if (collegesJson != null) {
      return CollegesResponse.fromJsonMap(json.decode(collegesJson));
    } else {
      return getCollegeS();
    }
  }

  Future persistColleges(CollegesResponse collegesResponse) {
    return Future.wait<dynamic>([
      storageApiProvider.writeValue(
          key: "colleges", value: json.encode(collegesResponse.toJson()))
    ]);
  }

  Future<CollegesResponse> getCollegeS() async {
    String token = await storageApiProvider.getToken();
    var collegesJson =
        await serverApiProvider.get(token: token, route: "$baseUrl/");
    var collegesResponse = CollegesResponse.fromListMap(collegesJson);
    persistColleges(collegesResponse);
    return collegesResponse;
  }

  Future<CollegeResponse> getCollege(int id) async {
    String token = await storageApiProvider.getToken();
    var collegeJson =
        await serverApiProvider.get(route: "$baseUrl/$id", token: token);
    var collegeResponse = CollegeResponse.fromJsonMap(collegeJson);
    return collegeResponse;
  }

  Future<bool> deleteCollege(int id) async {
    try {
      String token = await storageApiProvider.getToken();
      await serverApiProvider.delete(route: "$baseUrl/$id", token: token);
    } catch (_) {
      print("error: ${_.toString()}");
      return false;
    }
    return true;
  }

  Future<CollegeResponse> updateCollege(CollegeRequest collegeRequest) async {
    String token = await storageApiProvider.getToken();
    var collegeJson = await serverApiProvider.put(
      body: collegeRequest.toJson(),
      route: "$baseUrl/",
      token: token,
    );
    var collegeResponse = CollegeResponse.fromJsonMap(collegeJson);
    return collegeResponse;
  }

  Future<CollegeResponse> createCollege(CollegeRequest collegeRequest) async {
    String token = await storageApiProvider.getToken();
    var collegeJson = await serverApiProvider.post(
      body: collegeRequest.toJson(),
      route: "$baseUrl/",
      token: token,
    );
    var collegeResponse = CollegeResponse.fromJsonMap(collegeJson);
    return collegeResponse;
  }

  Future<CollegeResponse> addCourse(
      {int collegeID, CourseResponse courseResponse}) async {
    String token = await storageApiProvider.getToken();
    var collegeJson = await serverApiProvider.post(
        body: courseResponse.toJson(),
        route: "$baseUrl/$collegeID/add-course",
        token: token);
    var collegeResponse = CollegeResponse.fromJsonMap(collegeJson);
    return collegeResponse;
  }

  Future<PrincipalAssignResponse> addPrincipal(
      {int collegeID, int instructorId}) async {
    String token = await storageApiProvider.getToken();
    var response = await serverApiProvider.post(
        body: null,
        route: "$baseUrl/$collegeID/add-principal/$instructorId",
        token: token);
    print(response);
    var principalResponse = PrincipalAssignResponse.fromJsonMap(response);
    print(principalResponse);
    return principalResponse;
  }
}
