
import 'package:equatable/equatable.dart';
import 'package:ums_flutter/models/response/course_response.dart';

class CollegeResponse extends Equatable{

  int id;
  String name;
  String code;
  String address;
  String phone;
  String email;
  List<CourseResponse> courses = List<CourseResponse>();

	CollegeResponse.fromJsonMap(Map<String, dynamic> map){
		id = map["id"];
		name = map["name"];
		code = map["code"];
		address = map["address"];
		phone = map["phone"];
		email = map["email"];
		map["courses"].forEach((course) => courses.add(CourseResponse.fromJsonMap(course)));
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['code'] = code;
		data['address'] = address;
		data['phone'] = phone;
		data['email'] = email;
		data['courses'] = courses;
		return data;
	}

  @override
  // TODO: implement props
  List<Object> get props => null;
}
