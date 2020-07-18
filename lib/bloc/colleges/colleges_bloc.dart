import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/models/response/response.dart';
import 'package:ums_flutter/services/college_service.dart';

import '../bloc.dart';

class CollegesBloc extends Bloc<CollegesEvent, CollegesState> {
  final CollegeService collegeService;
  final CourseBloc courseBloc;
  StreamSubscription courseSubscription;

  CollegesBloc({@required this.collegeService, @required this.courseBloc})
      : assert(collegeService != null),
        assert(courseBloc != null) {
    courseSubscription = courseBloc.listen((courseState) {
      //Fixme add state course update and course created successfully
      //fixme then ask for navigation on dialog box and change the state to course load success on exit.
      if (courseState is CourseEditFetchSuccess) {
        add(CollegeUpdatedById(
            collegeId: courseState.collegeId,
            courseResponse: courseState.courseResponse));
      }
    });
  }

  @override
  CollegesState get initialState => CollegesLoadInProgress();

  @override
  Stream<CollegesState> mapEventToState(CollegesEvent event) async* {
    if (event is CollegesLoaded) {
      yield* _mapCollegesLoadedToState();
    } else if (event is CollegesUpdated) {
      yield* _mapCollegesUpdateToState();
    } else if (event is CollegeCreated) {
      yield* _mapCollegeCreatedToState(event);
    } else if (event is CollegeUpdated) {
      yield* _mapCollegeUpdatedToState(event);
    } else if (event is CollegeFetch) {
      yield* _mapCollegeFetchToState(event);
    } else if (event is CollegeUpdatedById) {
      yield* _mapCollegeUpdatedById(event);
    } else if (event is CollegeUpdatePrincipal) {
      yield* _mapCollegeUpdatePrincipalToState(event);
    }
  }

  //this function gets all the colleges from repo if saved else from server
  Stream<CollegesState> _mapCollegesLoadedToState() async* {
    try {
      final collegesResponse = await this.collegeService.loadCollegeS();
      yield CollegesLoadSuccess(collegesResponse: collegesResponse.colleges);
    } catch (_) {
      print("error: ${_.toString()}");
      yield CollegesLoadError(_);
    }
  }

  //this function gets college from server and refreshes the local cache
  Stream<CollegesState> _mapCollegesUpdateToState() async* {
    try {
      yield CollegesLoadInProgress();
      final collegesResponse = await this.collegeService.getCollegeS();
      yield CollegesLoadSuccess(collegesResponse: collegesResponse.colleges);
    } catch (_) {
      print("error: ${_.toString()}");
      yield CollegesLoadError(_);
    }
  }

  //this function is used to create new college or edit exiting college
  // if id is null then it means its a new request. else, its an edited request
  Stream<CollegesState> _mapCollegeCreatedToState(CollegeCreated event) async* {
    try {
      if (state is CollegesLoadSuccess) {
        //this is new addition in might v
        List<CollegeResponse> updatedColleges =
            (state as CollegesLoadSuccess).collegesResponse;
        yield CollegesLoadInProgress();
        //if id == null, create; else update existing college
        if (event.collegeRequest.id == null) {
          CollegeResponse collegeResponse =
              await this.collegeService.createCollege(event.collegeRequest);
          updatedColleges.add(collegeResponse);
        } else {
          final collegeResponse =
              await this.collegeService.updateCollege(event.collegeRequest);
          updatedColleges =
              (state as CollegesLoadSuccess).collegesResponse.map((college) {
            return college.id == collegeResponse.id ? collegeResponse : college;
          }).toList();
        }
        //finally update in local repository
        collegeService
            .persistColleges(CollegesResponse(colleges: updatedColleges));
        yield CollegesLoadSuccess(collegesResponse: updatedColleges);
      }
    } catch (_) {
      print("error: ${_.toString()}");
      yield CollegesLoadError(_);
    }
  }

  //for college data to be updated from other blocks (course block)
  Stream<CollegesState> _mapCollegeUpdatedToState(CollegeUpdated event) async* {
    try {
      if (state is CollegesLoadSuccess) {
        if (event.collegeIndex != -1 &&
            event.collegeIndex <
                (state as CollegesLoadSuccess).collegesResponse.length) {
          List<CollegeResponse> updatedColleges =
              (state as CollegesLoadSuccess).collegesResponse;
          updatedColleges[event.collegeIndex] = event.collegeResponse;
          collegeService
              .persistColleges(CollegesResponse(colleges: updatedColleges));
          yield CollegesLoadSuccess(collegesResponse: updatedColleges);
        } else {
          final List<CollegeResponse> updatedColleges =
              (state as CollegesLoadSuccess).collegesResponse.map((college) {
            return college.id == event.collegeResponse.id
                ? event.collegeResponse
                : college;
          }).toList();
          collegeService
              .persistColleges(CollegesResponse(colleges: updatedColleges));
          yield CollegesLoadSuccess(collegesResponse: updatedColleges);
        }
      }
    } catch (_) {
      print("error: ${_.toString()}");
      yield CollegesLoadError(_);
    }
  }

  //to fetch and update college details to list from server
  Stream<CollegesState> _mapCollegeFetchToState(CollegeFetch event) async* {
    try {
      if (state is CollegesLoadSuccess) {
        final List<CollegeResponse> oldColleges =
            (state as CollegesLoadSuccess).collegesResponse;
        final CollegeResponse collegeResponse =
            await this.collegeService.getCollege(event.collegeResponse.id);
        final List<CollegeResponse> updatedColleges =
            oldColleges.map((college) {
          return college.id == event.collegeResponse.id
              ? collegeResponse
              : college;
        }).toList();
        collegeService
            .persistColleges(CollegesResponse(colleges: updatedColleges));
        yield CollegesLoadSuccess(collegesResponse: updatedColleges);
      }
    } catch (_) {
      print("error: ${_.toString()}");
      yield CollegesLoadError(_);
    }
  }

  Stream<CollegesState> _mapCollegeUpdatedById(
      CollegeUpdatedById event) async* {
    try {
      if (state is CollegesLoadSuccess) {
        //get all the present colleges in the state
        var collegesResponse = (state as CollegesLoadSuccess).collegesResponse;
        //get the college by id and its index
        CollegeResponse college;
        int collegeIndex = collegesResponse.indexWhere((val) {
          if (val.id == event.collegeId) {
            college = val;
            return true;
          }
          return false;
        });
        //index1 is where course with id is present. -1 means not present
        int courseIndex1 = -1;
        //course index 2 is to check if the equal course is present, -1 if absent
        int courseIndex2 = college.courses.indexWhere((course) {
          if (course.id == event.courseResponse.id) {
            courseIndex1 = course.id;
            courseIndex1++;
          }
          return course == event.courseResponse;
        });
        //if course is present(courseIndex1 != -1)
        if (courseIndex1 != -1) {
          //course is unchanged(courseIndex2 != -1) then ignore
          if (courseIndex2 != -1) {
            yield CollegesLoadSuccess(collegesResponse: collegesResponse);
          } else {
            //if course is changed then replace and update.
            CollegeResponse updatedCollege = college.copyWith(
                courses: college.courses
                  ..replaceRange(
                      courseIndex1, courseIndex1, [event.courseResponse]));
            _mapCollegeUpdatedToState(CollegeUpdated(
                collegeResponse: updatedCollege, collegeIndex: collegeIndex));
          }
        } else {
          //if course is absent (courseIndex1 = -1) then add and update
          var updatedCollege = college.copyWith(
              courses: college.courses..add(event.courseResponse));
          _mapCollegeUpdatedToState(CollegeUpdated(
              collegeResponse: updatedCollege, collegeIndex: collegeIndex));
        }
      }
    } catch (_) {
      print("error: ${_.toString()}");
      yield CollegesLoadError(_);
    }
  }

  Stream<CollegesState> _mapCollegeUpdatePrincipalToState(
      CollegeUpdatePrincipal event) async* {
    try {
      if (state is CollegesLoadSuccess) {
        //get all the present colleges in the state
        var collegesResponse = (state as CollegesLoadSuccess).collegesResponse;
        // update the principal where college id match
        collegesResponse = collegesResponse.map((college) {
          if (college.id == event.principalAssignResponse.id) {
            print(event.principalAssignResponse.principal);
            print(college.principal.runtimeType);
            return college.copyWith(principal: event.principalAssignResponse.principal);
          } else {
            return college;
          }
        }).toList();
        collegeService
            .persistColleges(CollegesResponse(colleges: collegesResponse));
        yield CollegesLoadSuccess(collegesResponse: collegesResponse);
      }
    }
    catch (_) {
      yield CollegesLoadError(_);
    }
  }

  @override
  Future<void> close() {
    courseSubscription.cancel();
    return super.close();
  }
}
