import 'package:bloc/bloc.dart';
import 'package:ums_flutter/event_state/course/course_state.dart';
import 'package:ums_flutter/event_state/course/course_event.dart';
import 'package:ums_flutter/models/response/college_response.dart';
import 'package:ums_flutter/models/response/course_response.dart';
import 'package:ums_flutter/services/course_service.dart';


//todo refactor after CUD
class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseService courseService;

  CourseBloc({this.courseService}) : assert(courseService != null);

  @override
  get initialState => CourseAbsent();

  @override
  Stream<CourseState> mapEventToState(CourseEvent event) async* {
    try{
      if (event is GetCourse){
        yield CourseLoading();
        CourseResponse courseResponse = await courseService.getCourse(event.id);
        yield CourseAdded(courseResponse: courseResponse);
      }
      else if (event is UpdateCourse){
        yield CourseLoading();
        CourseResponse courseResponse = await courseService.updateCourse(event.courseRequest);
        yield CourseAdded(courseResponse: courseResponse);
      }
      else if (event is CreateCourse){
        yield CourseLoading();
        CollegeResponse collegeResponse = await courseService.addCourse(collegeID: event.collegeId, courseRequest: event.courseRequest);
        yield CourseCreated(collegeResponse: collegeResponse);
      }
      //todo remove from colleges list once deleted
      else if (event is DeleteCourse){
        yield CourseLoading();
        await courseService.deleteCourse(event.id);
        yield CourseAbsent();
      }

    }catch (error) {
      yield CourseError(error: error.toString());
    }
  }


}