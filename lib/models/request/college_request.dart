import 'package:flutter/foundation.dart';

import '../models.dart';

class CollegeRequest {
  int id;
  String name;
  String code;
  String phone;
  String email;
  String address;

  CollegeRequest({
    this.id,
    this.name,
    this.code,
    this.address,
    this.phone,
    this.email,
  });

  CollegeRequest.create({
    @required this.name,
    @required this.code,
    @required this.address,
    @required this.email,
    @required this.phone,
  });

  CollegeRequest.fromResponse({CollegeResponse collegeResponse}){
    this.id = collegeResponse.id;
    this.name = collegeResponse.name;
    this.code = collegeResponse.code;
    this.address = collegeResponse.address;
    this.email = collegeResponse.email;
    this.phone = collegeResponse.phone;
  }

  CollegeRequest.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        code = map["code"],
        phone = map["phone"],
        email = map["email"],
        address = map["address"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['phone'] = phone;
    data['email'] = email;
    data['address'] = address;
    return data;
  }
}
