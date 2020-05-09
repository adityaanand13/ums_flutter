import 'package:ums_flutter/models/response/group_response.dart';

class SectionResponse {

  int id;
  String name;
  String description;
  List<GroupResponse> groups;

	SectionResponse.fromJsonMap(Map<String, dynamic> map):
		id = map["id"],
		name = map["name"],
		description = map["description"],
		groups = List<GroupResponse>.from(map["groups"].map((it) => GroupResponse.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['description'] = description;
		data['groups'] = groups != null ? 
			this.groups.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
