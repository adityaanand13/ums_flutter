class CollegeRequest {

  int id = null;
  String name;
  String description;
  String code;
  String address;

	CollegeRequest.fromJsonMap(Map<String, dynamic> map):
		id = map["id"],
		name = map["name"],
		description = map["description"],
		code = map["code"],
		address = map["address"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['description'] = description;
		data['code'] = code;
		data['address'] = address;
		return data;
	}
}
