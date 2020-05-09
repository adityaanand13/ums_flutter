import 'package:ums_flutter/models/response/section_response.dart';
import 'package:ums_flutter/models/response/subject_response.dart';

class SemesterResponse {

  int id;
  String name;
  bool isActive;
  int seq;
  List<SectionResponse> sections;
  List<SubjectResponse> subjects;

	SemesterResponse.fromJsonMap(Map<String, dynamic> map):
		id = map["id"],
		name = map["name"],
		isActive = map["isActive"],
		seq = map["seq"],
		sections = List<SectionResponse>.from(map["sections"].map((it) => SectionResponse.fromJsonMap(it))),
		subjects = List<SubjectResponse>.from(map["subjects"].map((it) => SubjectResponse.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['isActive'] = isActive;
		data['seq'] = seq;
		data['sections'] = sections != null ? 
			this.sections.map((v) => v.toJson()).toList()
			: null;
		data['subjects'] = subjects != null ? 
			this.subjects.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
