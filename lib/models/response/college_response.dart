import 'package:equatable/equatable.dart';
import 'package:ums_flutter/models/response/course_response.dart';

import '../user_model.dart';

class CollegeResponse extends Equatable {
  final int id;
  final String name;
  final String code;
  final String address;
  final String phone;
  final String email;
  final UserModel principal;
  final List<CourseResponse> courses;

  CollegeResponse.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        code = map["code"],
        address = map["address"],
        phone = map["phone"],
        email = map["email"],
        principal =
            map["principal"] != null ? UserModel.fromJsonMap(map["principal"]) : null,
        courses = map["courses"] != null
            ? List<CourseResponse>.from(
                map["courses"].map((it) => CourseResponse.fromJsonMap(it)))
            : null;

  CollegeResponse(
      {this.id,
      this.name,
      this.code,
      this.address,
      this.phone,
      this.email,
      this.courses,
      this.principal});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['address'] = address;
    data['phone'] = phone;
    data['email'] = email;
    data['principal'] = principal;
    data['courses'] =
        courses != null ? this.courses.map((v) => v.toJson()).toList() : null;
    return data;
  }

  @override
  List<Object> get props => [id, name, code, address, phone, email, courses];

  CollegeResponse copyWith({
    int id,
    String name,
    String code,
    String address,
    String phone,
    String email,
    UserModel principal,
    List<CourseResponse> courses,
  }) {
    return CollegeResponse(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        principal: principal ?? this.principal,
        courses: courses ?? this.courses);
  }
}
