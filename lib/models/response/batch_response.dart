import 'package:ums_flutter/models/response/semester_response.dart';

class BatchResponse {

  int id;
  String name;
  List<SemesterResponse> semesters;

	BatchResponse.fromJsonMap(Map<String, dynamic> map):
		id = map["id"],
		name = map["name"],
		semesters = List<SemesterResponse>.from(map["semesters"].map((it) => SemesterResponse.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['semesters'] = semesters != null ? 
			this.semesters.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
