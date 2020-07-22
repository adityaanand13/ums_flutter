import 'package:meta/meta.dart';
import 'package:ums_flutter/api/api.dart';
import 'package:ums_flutter/models/models.dart';
import 'package:ums_flutter/utils/utils.dart';

class SemesterService {
  final ServerApiProvider serverApiProvider;
  final StorageApiProvider storageApiProvider;

  SemesterService({@required this.serverApiProvider, @required this.storageApiProvider});

  final _baseUrl = SEMESTER_URL;

  Future<SemesterResponse> getSemester(int id) async {
    String token = await storageApiProvider.getToken();
    var semesterResponse = await serverApiProvider.get(route:"$_baseUrl/$id", token: token);
    return SemesterResponse.fromJsonMap(semesterResponse);
  }

  Future<SemesterResponse> activate(int id) async {
    String token = await storageApiProvider.getToken();
    var semesterResponse = await serverApiProvider.patch(route:"$_baseUrl/$id/activate", token: token,);
    return SemesterResponse.fromJsonMap(semesterResponse);
  }
}