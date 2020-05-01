import 'package:bloc/bloc.dart';
import 'package:ums_flutter/event_state/batch/batch_event.dart';
import 'package:ums_flutter/event_state/batch/batch_state.dart';
import 'package:ums_flutter/event_state/course/course_state.dart';
import 'package:ums_flutter/event_state/course/course_event.dart';
import 'package:ums_flutter/models/response/batch_response.dart';
import 'package:ums_flutter/models/response/college_response.dart';
import 'package:ums_flutter/models/response/course_response.dart';
import 'package:ums_flutter/services/batch_service.dart';
import 'package:ums_flutter/services/course_service.dart';


//todo refactor after CUD
class BatchBloc extends Bloc<BatchEvent, BatchState> {
  final BatchService batchService;

  BatchBloc({this.batchService}) : assert(batchService != null);

  @override
  get initialState => BatchAbsent();

  @override
  Stream<BatchState> mapEventToState(BatchEvent event) async* {
    try{
      if (event is GetBatch){
        yield BatchLoading();
        BatchResponse batchResponse = await batchService.getBatch(event.id);
        yield BatchAdded(batchResponse: batchResponse);
      }
      else if (event is UpdateBatch){
        yield BatchLoading();
        BatchResponse batchResponse = await batchService.updateBatch(event.batchRequest);
        yield BatchAdded(batchResponse: batchResponse);
      }
      else if (event is CreateBatch){
        yield BatchLoading();
        CourseResponse courseResponse = await batchService.addBatch(courseID: event.courseId, batchRequest: event.batchRequest);
        yield BatchCreated(courseResponse: courseResponse);
      }
      //todo remove from colleges list once deleted
      else if (event is DeleteBatch){
        yield BatchLoading();
        await batchService.deleteBatch(event.id);
        yield BatchAbsent();
      }

    }catch (error) {
      yield BatchError(error: error.toString());
    }
  }


}