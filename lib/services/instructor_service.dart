import 'package:meta/meta.dart';
import 'package:ums_flutter/api/api.dart';
import 'package:ums_flutter/models/models.dart';
import 'package:ums_flutter/utils/utils.dart';

class InstructorService {
  final ServerApiProvider serverApiProvider;
  final StorageApiProvider storageApiProvider;

  InstructorService(
      {@required this.serverApiProvider, @required this.storageApiProvider});

  final String _baseUrl = INSTRUCTOR_URL;

  Future<InstructorModel> getInstructor(String username) async {
    String token = await storageApiProvider.getToken();
    return InstructorModel.fromJsonMap(
        await serverApiProvider.get(
            route: "$_baseUrl/$username", token: token));
  }

  Future<UsernamesResponse> searchInstructor(String key) async {
    String token = await storageApiProvider.getToken();
    var response = await serverApiProvider.get(
        route: "$_baseUrl/username/$key", token: token);
    return UsernamesResponse.fromListMap(response);
  }

//  Future<bool> deleteInstructor() async {
//    try{
//      await securedStorage.delete(key: "user");
//      return true;
//    }catch(_){
//      return false;
//    }
//  }

  Future<InstructorModel> addInstructor(InstructorModel instructorModel) async {
    String token = await storageApiProvider.getToken();
    return InstructorModel.fromJsonMap(await serverApiProvider.post(
        body: instructorModel.toJson(), route: "$_baseUrl/", token: token));
  }
}
