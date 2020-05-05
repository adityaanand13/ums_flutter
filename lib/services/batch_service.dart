import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ums_flutter/api/batch_api.dart';
import 'package:ums_flutter/api/course_api.dart';
import 'package:ums_flutter/models/request/batch_request.dart';
import 'package:ums_flutter/models/response/batch_response.dart';
import 'package:ums_flutter/models/response/course_response.dart';
import 'package:ums_flutter/models/response/course_response.dart';

class BatchService {
  BatchApiProvider _provider = BatchApiProvider();
  CourseApiProvider _courseApiProvider = CourseApiProvider();
  FlutterSecureStorage _storage = new FlutterSecureStorage();

  //todo refactor
  Future<CourseResponse> addBatch({int courseID, BatchRequest batchRequest}) async {
    String token = await _storage.read(key: "token");
    var courseJson = await _courseApiProvider.post(batchRequest.toJson(), "$courseID/add-batch", token);
    var courseResponse = CourseResponse.fromJsonMap(courseJson);
    return courseResponse;
  }

  Future<BatchResponse> getBatch(int id) async {
    String token = await _storage.read(key: "token");
    var batchJson = await _provider.get("$id", token);
    var batchResponse = BatchResponse.fromJsonMap(batchJson);
    return batchResponse;
  }

  Future<bool> deleteBatch(int id) async {
    //todo refactor return
    String token = await _storage.read(key: "token");
    var batchJson = await _provider.delete("$id", token);
    return true;
  }

  Future<BatchResponse> updateBatch(BatchRequest batchRequest) async {
    String token = await _storage.read(key: "token");
    var batchJson = await _provider.put(batchRequest.toJson(), "", token);
    var batchResponse = BatchResponse.fromJsonMap(batchJson);
    return batchResponse;
  }

//  Future<CollegeResponse> addBatch({int courseID, BatchResponse batchResponse}) async {
//    String token = await _storage.read(key: "token");
//    var courseJson = await _provider.post(batchResponse.toJson(), "$courseID/add-batch", token);
//    var courseResponse = CollegeResponse.fromJsonMap(courseJson);
//    return courseResponse;
//  }

}