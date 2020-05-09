
import 'college_response.dart';

class CollegesResponse {
  List<CollegeResponse> colleges;

  CollegesResponse.fromJsonMap(Map<String, dynamic> map):
        colleges = List<CollegeResponse>.from(map["colleges"].map((it) => CollegeResponse.fromJsonMap(it)));

  CollegesResponse.fromListMap(List<dynamic> collegesResponse)
      : colleges = List<CollegeResponse>.from(collegesResponse.map(
          (collegeResponse) => CollegeResponse.fromJsonMap(collegeResponse)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['colleges'] = colleges != null ?
    this.colleges.map((v) => v.toJson()).toList()
        : null;
    return data;
  }
}