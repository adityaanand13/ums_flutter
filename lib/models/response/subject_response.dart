
import 'package:equatable/equatable.dart';

class SubjectResponse extends Equatable{

  final int id;
  final String name;
  final String description;

	SubjectResponse.fromJsonMap(Map<String, dynamic> map):
		id = map["id"],
		name = map["name"],
		description = map["description"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['description'] = description;
		return data;
	}

  @override
  // TODO: implement props
  List<Object> get props => [id, name, description];
}
