import 'package:meta/meta.dart';
import 'package:ums_flutter/api/api.dart';
import 'package:ums_flutter/models/models.dart';
import 'package:ums_flutter/utils/utils.dart';

class CourseService {
  final ServerApiProvider serverApiProvider;
  final StorageApiProvider storageApiProvider;

  CourseService({@required this.serverApiProvider, @required this.storageApiProvider});

  final String _baseUrl = COURSE_URL;
  final String _collegeUrl = COLLEGE_URL;


  //todo refactor
  Future<CollegeResponse> addCourse(
      {@required int collegeID, @required CourseRequest courseRequest}) async {
    String token = await storageApiProvider.getToken();
    var collegeJson = await serverApiProvider.post(
        body: courseRequest.toJson(),
        route: "$_collegeUrl/$collegeID/add-course",
        token: token);
    var collegeResponse = CollegeResponse.fromJsonMap(collegeJson);
    return collegeResponse;
  }

  Future<CourseResponse> getCourse({@required int id}) async {
    String token = await storageApiProvider.getToken();
    var courseJson = await serverApiProvider.get(route: "$_baseUrl/$id", token: token);
    var courseResponse = CourseResponse.fromJsonMap(courseJson);
    return courseResponse;
  }

  Future<bool> deleteCourse({@required int courseId}) async {
    try {
      String token = await storageApiProvider.getToken();
      await serverApiProvider.delete(route: "$_baseUrl/$courseId", token: token);
      return true;
    } catch (_) {
      print("error: ${_.toString()}");
      return false;
    }
  }

  Future<CourseResponse> updateCourse(
      {@required CourseRequest courseRequest}) async {
    String token = await storageApiProvider.getToken();
    var courseJson = await serverApiProvider.put(
        body: courseRequest.toJson(), route: "$_baseUrl/", token: token);
    var courseResponse = CourseResponse.fromJsonMap(courseJson);
    return courseResponse;
  }
}
