
class CollegeResponse {

  int id;
  String name;
  String description;
  String code;
  String address;
//  List<Object> courses;

	CollegeResponse.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		name = map["name"],
		description = map["description"],
		code = map["code"],
		address = map["address"];
//		courses = map["courses"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['description'] = description;
		data['code'] = code;
		data['address'] = address;
//		data['courses'] = courses;
		return data;
	}
}
