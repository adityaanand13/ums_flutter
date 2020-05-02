
class BatchResponse {

  int id;
  String name;
  String description;
  List<Object> semesters;

	BatchResponse.fromJsonMap(Map<String, dynamic> map):
		id = map["id"],
		name = map["name"],
		description = map["description"],
		semesters = map["semesters"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['description'] = description;
		data['semesters'] = semesters;
		return data;
	}
}
