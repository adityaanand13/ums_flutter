import 'package:meta/meta.dart';
import 'package:ums_flutter/api/api.dart';
import 'package:ums_flutter/models/models.dart';
import 'package:ums_flutter/utils/utils.dart';

class BatchService {
  final ServerApiProvider serverApiProvider;
  final StorageApiProvider storageApiProvider;

  final String _baseUrl = BATCH_URL;
  final String _courseUrl = COURSE_URL;

  BatchService({@required this.serverApiProvider,@required this.storageApiProvider});


  //todo refactor
  Future<CourseResponse> addBatch(
      {int courseID, BatchRequest batchRequest}) async {
    String token = await storageApiProvider.getToken();
    var courseJson = await serverApiProvider.post(
        route: "$_courseUrl/$courseID/add-batch/${batchRequest.name}",
        token: token);
    return CourseResponse.fromJsonMap(courseJson);
  }

  Future<BatchResponse> getBatch(int id) async {
    String token = await storageApiProvider.getToken();
    var batchJson =
        await serverApiProvider.get(route: "$_baseUrl/$id", token: token);
    return BatchResponse.fromJsonMap(batchJson);
  }

  Future<bool> deleteBatch(int id) async {
    try {
      String token = await storageApiProvider.getToken();
      await serverApiProvider.delete(route: "$_baseUrl/$id", token: token);
      return true;
    } catch (_) {
      print("error: ${_.toString()}");
      return false;
    }
  }

  Future<BatchResponse> updateBatch(BatchRequest batchRequest) async {
    String token = await storageApiProvider.getToken();
    var batchJson = await serverApiProvider.put(
        body: batchRequest.toJson(), route: "$_baseUrl/", token: token);
    return BatchResponse.fromJsonMap(batchJson);
  }

//  Future<CollegeResponse> addBatch({int courseID, BatchResponse batchResponse}) async {
//    String token = await _storage.read(key: "token");
//    var courseJson = await _provider.post(batchResponse.toJson(), "$courseID/add-batch", token);
//    var courseResponse = CollegeResponse.fromJsonMap(courseJson);
//    return courseResponse;
//  }

}
