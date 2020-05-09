import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/models/response/college_response.dart';
import 'package:ums_flutter/services/college_service.dart';
import './bloc.dart';

class CollegesBloc extends Bloc<CollegesEvent, CollegesState> {
  final CollegeService collegeService;

  CollegesBloc({@required this.collegeService})
      : assert(collegeService != null);

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
    }
  }

  //this function gets all the colleges from repo if saved else from server
  Stream<CollegesState> _mapCollegesLoadedToState() async* {
    try {
      final collegesResponse = await this.collegeService.loadCollegeS();
      yield CollegesLoadSuccess(collegesResponse.colleges);
    } catch (_) {
      yield CollegesLoadError(_);
    }
  }

  //this function gets college from server and refreshes the local cache
  Stream<CollegesState> _mapCollegesUpdateToState() async* {
    try {
      yield CollegesLoadInProgress();
      final collegesResponse = await this.collegeService.getCollegeS();
      yield CollegesLoadSuccess(collegesResponse.colleges);
    } catch (_) {
      yield CollegesLoadError(_);
    }
  }

  //this function is used to create new college or edit exiting college
  // if id is null then it means its a new request. else, its an edited request
  Stream<CollegesState> _mapCollegeCreatedToState(CollegeCreated event) async* {
    try {
      if (state is CollegesLoadSuccess) {
        if (event.collegeRequest.id == null) {
          final collegeResponse =
              await this.collegeService.createCollege(event.collegeRequest);
          final List<CollegeResponse> updatedColleges =
              List.from((state as CollegesLoadSuccess).collegesResponse)
                ..add(collegeResponse);
          yield CollegesLoadSuccess(updatedColleges);
        } else {
          final collegeResponse =
              await this.collegeService.updateCollege(event.collegeRequest);
          final List<CollegeResponse> updatedColleges =
              (state as CollegesLoadSuccess).collegesResponse.map((college) {
            return college.id == collegeResponse.id ? collegeResponse : college;
          }).toList();
          yield CollegesLoadSuccess(updatedColleges);
        }
      }
    } catch (_) {
      yield CollegesLoadError(_);
    }
  }

  //for college data to be updated from other blocks (course block)
  Stream<CollegesState> _mapCollegeUpdatedToState(CollegeUpdated event) async* {
    try {
      final List<CollegeResponse> updatedColleges =
          (state as CollegesLoadSuccess).collegesResponse.map((college) {
        return college.id == event.collegeResponse.id
            ? event.collegeResponse
            : college;
      }).toList();
      yield CollegesLoadSuccess(updatedColleges);
    } catch (_) {
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
        print(collegeResponse.courses[1].name);
        final List<CollegeResponse> updatedColleges =
            oldColleges.map((college) {
          return college.id == event.collegeResponse.id
              ? collegeResponse
              : college;
        }).toList();
        yield CollegesLoadSuccess(updatedColleges);
      }
    } catch (_) {
      yield CollegesLoadError(_);
    }
  }
}
