import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/models/response/response.dart';
import 'package:ums_flutter/services/batch_service.dart';

import '../bloc.dart';

class BatchBloc extends Bloc<BatchEvent, BatchState> {
  final BatchService batchService;
  final SemesterBloc semesterBloc;
  StreamSubscription semesterSubscription;

  BatchBloc({@required this.batchService, @required this.semesterBloc});

  @override
  BatchState get initialState => BatchLoadInProgress();

  @override
  Stream<BatchState> mapEventToState(
    BatchEvent event,
  ) async* {
    if (event is BatchAdd) {
      yield* _mapBatchAddToState(event);
    } else if (event is BatchCreate) {
      yield* _mapBatchCreateToState(event);
    } else if (event is BatchUpdateOTA) {
      yield* _mapBatchUpdateOTAToState(event);
    } else if (event is BatchFetch) {
      yield* _mapBatchFetchToState(event);
    } else if (event is BatchUpdateInternal) {
      yield* _mapBatchUpdateInternalToState(event);
    } else if (event is BatchDelete) {
      yield* _mapBatchDeleteToState(event);
    }
  }

  Stream<BatchState> _mapBatchAddToState(BatchAdd event) async* {
    yield BatchLoadSuccess(
        batchResponse: event.batchResponse, courseId: event.courseId);
  }

  Stream<BatchState> _mapBatchCreateToState(BatchCreate event) async* {
    try {
//      print(state);
//      if (state is BatchLoadSuccess) {
      yield BatchLoadInProgress();
      print("request ${event.batchRequest.name}");
      CourseResponse updatedCourse = await batchService.addBatch(
          courseID: event.courseId, batchRequest: event.batchRequest);
      //change the strategy to update course
      //todo refactor batch details in back-end db to store start and end year instead of batch name
      var batchResponse = updatedCourse.batches.singleWhere((batch) {
        List<String> name = batch.name.split(":");
        name = name[1].split("-");
        print(name[0]);
        return name[0] == event.batchRequest.name;
      });
      print(batchResponse);
      yield BatchLoadSuccess(
          batchResponse: batchResponse,
          courseId: event.courseId);
//      }
    } catch (_) {
      print("error: ${_.toString()}");
      yield BatchLoadError(error: _.toString());
    }
  }

  Stream<BatchState> _mapBatchUpdateOTAToState(BatchUpdateOTA event) async* {
    try {
      if (state is BatchLoadSuccess) {
        yield BatchLoadInProgress();
        yield BatchLoadSuccess(
            batchResponse: await batchService.updateBatch(event.batchRequest),
            courseId: event.courseId);
      }
    } catch (_) {
      print("error: ${_.toString()}");
      yield BatchLoadError(error: _);
    }
  }

  Stream<BatchState> _mapBatchFetchToState(BatchFetch event) async* {
    yield BatchLoadInProgress();
    BatchResponse batchResponse = await batchService.getBatch(event.batchId);
    yield BatchLoadSuccess(
        batchResponse: batchResponse, courseId: event.courseId);
  }

  Stream<BatchState> _mapBatchUpdateInternalToState(
      BatchUpdateInternal event) async* {
    try {
      if (state is BatchLoadSuccess) {
        List<SemesterResponse> semestersResponse =
            (state as BatchLoadSuccess).batchResponse.semesters;
        if (semestersResponse.contains(event.semesterResponse)) {
          yield state;
        } else {
          int semesterIndex = semestersResponse
              .indexWhere((element) => element.id == event.semesterResponse.id);
          if (semesterIndex != -1) {
            semestersResponse[semesterIndex] = event.semesterResponse;
          } else {
            semestersResponse.add(event.semesterResponse);
          }
          BatchResponse batchResponse = (state as BatchLoadSuccess)
              .batchResponse
              .copyWith(semesters: semestersResponse);
          yield BatchLoadSuccess(
              batchResponse: batchResponse,
              courseId: (state as BatchLoadSuccess).courseId);
        }
      }
    } catch (_) {
      print("error: ${_.toString()}");
      yield BatchLoadError(error: _);
    }
  }

  //todo work on architecture
  Stream<BatchState> _mapBatchDeleteToState(BatchDelete event) async* {}

  @override
  Future<void> close() {
    semesterSubscription.cancel();
    return super.close();
  }
}
