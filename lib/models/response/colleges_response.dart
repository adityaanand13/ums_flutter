import 'package:meta/meta.dart';
import 'college_response.dart';

class CollegesResponse {
  final List<CollegeResponse> colleges;

  CollegesResponse({@required this.colleges});

  CollegesResponse.fromJsonMap(Map<String, dynamic> map)
      : colleges = List<CollegeResponse>.from(
            map["colleges"].map((it) => CollegeResponse.fromJsonMap(it)));

  CollegesResponse.fromListMap(List<dynamic> collegesResponse)
      : colleges = List<CollegeResponse>.from(collegesResponse.map(
            (collegeResponse) => CollegeResponse.fromJsonMap(collegeResponse)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['colleges'] =
        colleges != null ? this.colleges.map((v) => v.toJson()).toList() : null;
    return data;
  }
}
