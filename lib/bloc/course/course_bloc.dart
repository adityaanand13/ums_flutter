import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/models/response/response.dart';
import 'package:ums_flutter/services/course_service.dart';

import '../bloc.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseService courseService;
  final BatchBloc batchBloc;
  StreamSubscription batchSubscription;

  CourseBloc({@required this.courseService, @required this.batchBloc})
      : assert(courseService != null),
        assert(batchBloc != null) {
    batchSubscription = batchBloc.listen((batchState) {
      if (batchState is BatchLoadSuccess) {
        add(CourseUpdateInternal(batchResponse: batchState.batchResponse));
      }
    });
  }

  @override
  CourseState get initialState => CourseLoadInProgress();

  @override
  Stream<CourseState> mapEventToState(CourseEvent event) async* {
    if (event is CourseLoadToUI) {
      yield* _mapCourseLoadToUIToEvent(event);
    } else if (event is CourseCreate) {
      yield* _mapCourseCreateToEvent(event);
    } else if (event is CourseUpdateOTA) {
      yield* _mapCourseUpdateOTAToState(event);
    } else if (event is CourseFetch) {
      yield* _mapCourseFetchToState(event);
    } else if (event is CourseUpdateInternal) {
      yield* _mapCourseUpdateInternalToState(event);
    } else if (event is CourseDelete) {
      yield* _mapCourseDeleteToState(event);
    }
  }

  Stream<CourseState> _mapCourseLoadToUIToEvent(CourseLoadToUI event) async* {
    yield CourseLoadSuccess(
        courseResponse: event.courseResponse, collegeId: event.collegeId);
  }

  Stream<CourseState> _mapCourseCreateToEvent(CourseCreate event) async* {
    try {
      yield CourseLoadInProgress();
      CollegeResponse updatedCourse = await courseService.addCourse(
          courseRequest: event.courseRequest, collegeID: event.collegeId);
      yield CourseEditFetchSuccess(
          courseResponse: updatedCourse.courses.singleWhere((course) {
            return course.name == event.courseRequest.name &&
                course.code == event.courseRequest.code;
          }),
          collegeId: updatedCourse.id);
    } catch (_) {
      print("error: ${_.toString()}");
      yield CourseLoadError(error: _);
    }
  }

  Stream<CourseState> _mapCourseUpdateOTAToState(CourseUpdateOTA event) async* {
    try {
      yield CourseLoadInProgress();
      CourseResponse updatedCourse =
          await courseService.updateCourse(courseRequest: event.courseRequest);
      yield CourseEditFetchSuccess(
          courseResponse: updatedCourse, collegeId: event.collegeId);
    } catch (_) {
      print("error: ${_.toString()}");
      yield CourseLoadError(error: _);
    }
  }

  Stream<CourseState> _mapCourseFetchToState(CourseFetch event) async* {
    try {
        yield CourseLoadInProgress();
        CourseResponse course =
            await courseService.getCourse(id: event.courseId);
        yield CourseEditFetchSuccess(courseResponse: course, collegeId: event.collegeId);
    } catch (_) {
      print("error: ${_.toString()}");
      yield CourseLoadError(error: _);
    }
  }

  Stream<CourseState> _mapCourseUpdateInternalToState(CourseUpdateInternal event) async* {
    try {
      if (state is CourseLoadSuccess) {
        List<BatchResponse> batchesResponse =
            (state as CourseLoadSuccess).courseResponse.batches;
        if (batchesResponse.contains(event.batchResponse)) {
          yield state;
        } else {
          int batchIndex = batchesResponse
              .indexWhere((element) => element.id == event.batchResponse.id);
          if (batchIndex != -1) {
            batchesResponse[batchIndex] = event.batchResponse;
          } else {
            batchesResponse.add(event.batchResponse);
          }
          CourseResponse courseResponse = (state as CourseLoadSuccess)
              .courseResponse
              .copyWith(batches: batchesResponse);
          yield CourseLoadSuccess(
              courseResponse: courseResponse,
              collegeId: (state as CourseLoadSuccess).collegeId);
        }
      }
    } catch (_) {
      print("error: ${_.toString()}");
      yield CourseLoadError(error: _);
    }
  }

  //todo work on architecture
  Stream<CourseState> _mapCourseDeleteToState(CourseDelete event) async* {}

  @override
  Future<void> close() {
    batchSubscription.cancel();
    return super.close();
  }
}
