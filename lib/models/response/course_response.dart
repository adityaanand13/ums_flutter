
import 'package:ums_flutter/models/response/batch_response.dart';

class CourseResponse {

  int id;
  String name;
  String code;
  String description;
  int duration;
  int semesterPerYear;
  List<BatchResponse> batches = List<BatchResponse>();

	CourseResponse.fromJsonMap(Map<String, dynamic> map){
		id = map["id"];
		name = map["name"];
		code = map["code"];
		description = map["description"];
		duration = map["duration"];
		semesterPerYear = map["semesterPerYear"];
		map["batches"].forEach((batch) => batches.add(BatchResponse.fromJsonMap(batch)));
	}


	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['code'] = code;
		data['description'] = description;
		data['duration'] = duration;
		data['semesterPerYear'] = semesterPerYear;
		data['batches'] = batches;
		return data;
	}
}
