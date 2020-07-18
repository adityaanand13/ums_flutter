
import 'package:equatable/equatable.dart';

class GroupResponse extends Equatable{

  final int id;
  final String name;

	GroupResponse.fromJsonMap(Map<String, dynamic> map):
		id = map["id"],
		name = map["name"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		return data;
	}

  @override
  // TODO: implement props
  List<Object> get props => [id, name];
}
