import 'package:equatable/equatable.dart';
import 'package:ums_flutter/models/response/group_response.dart';

class SectionResponse extends Equatable{

  final int id;
  final String name;
  final String description;
  final List<GroupResponse> groups;

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

  @override
  // TODO: implement props
  List<Object> get props => [id, name, description, groups];
}
