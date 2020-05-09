import 'package:ums_flutter/models/response/course_response.dart';

class CollegeResponse {
  int id;
  String name;
  String code;
  String address;
  String phone;
  String email;
  List<CourseResponse> courses;

  CollegeResponse.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        code = map["code"],
        address = map["address"],
        phone = map["phone"],
        email = map["email"],
        courses = map["courses"] != null
            ? List<CourseResponse>.from(
                map["courses"].map((it) => CourseResponse.fromJsonMap(it)))
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['address'] = address;
    data['phone'] = phone;
    data['email'] = email;
    data['courses'] =
        courses != null ? this.courses.map((v) => v.toJson()).toList() : null;
    return data;
  }
}
