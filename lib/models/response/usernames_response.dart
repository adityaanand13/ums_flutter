import 'package:ums_flutter/models/response/username.dart';

class UsernamesResponse {
  final List<Username> usernames;

  UsernamesResponse.fromJsonMap(Map<String, dynamic> map)
      : usernames = List<Username>.from(
            map["usernames"].map((it) => Username.fromJsonMap(it)));

  UsernamesResponse.fromListMap(List<dynamic> usernamesResponse)
      : usernames = List<Username>.from(usernamesResponse.map(
          (username) => Username.fromJsonMap(username)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usernames'] = usernames != null
        ? this.usernames.map((v) => v.toJson()).toList()
        : null;
    return data;
  }
}
