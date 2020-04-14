
import 'college_response.dart';

class CollegesResponse {
  List<CollegeResponse> colleges;
  CollegesResponse(){colleges = List<CollegeResponse>();}


  CollegesResponse.fromJsonMap(List<dynamic> collegesList){
    colleges = List<CollegeResponse>();
    collegesList.forEach((college)  =>  colleges.add(CollegeResponse.fromJsonMap(college)));
  }
}
//college present, college absent, college loading