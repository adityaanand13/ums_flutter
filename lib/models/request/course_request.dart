
class CourseRequest {

	int id = null;
	String name;
	String code;
	String description;
	int semesterPerYear;
	int duration;

	CourseRequest({this.id, this.name, this.code, this.description, this.duration, this.semesterPerYear});
	CourseRequest.create({this.name, this.code, this.description, this.duration, this.semesterPerYear});

	CourseRequest.fromJsonMap(Map<String, dynamic> map):
				id = map["id"],
				name = map["name"],
				code = map["code"],
				description = map["description"],
				duration = map["duration"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['code'] = code;
		data['description'] = description;
		data['duration'] = duration;
		data['semesterPerYear'] = semesterPerYear;
		return data;
	}
}
