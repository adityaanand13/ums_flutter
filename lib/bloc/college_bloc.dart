import 'package:bloc/bloc.dart';
import 'package:ums_flutter/event_state/college/college_event.dart';
import 'package:ums_flutter/event_state/college/college_state.dart';
import 'package:ums_flutter/models/response/college_response.dart';
import 'package:ums_flutter/models/response/college_s_response.dart';
import 'package:ums_flutter/services/college_service.dart';

//todo refactor after CUD
class CollegeBloc extends Bloc<CollegeEvent, CollegeState> {
  final CollegeService collegeService;

  CollegeBloc({this.collegeService}) : assert(collegeService != null);

  @override
  get initialState => CollegeAbsent();

  @override
  Stream<CollegeState> mapEventToState(CollegeEvent event) async* {
    try{
      if (event is GetCollege){
        yield CollegeLoading();
        CollegeResponse collegeResponse = await collegeService.getCollege(event.id);
        yield CollegeAdded(collegeResponse: collegeResponse);
      }
      else if (event is UpdateCollege){
        yield CollegeLoading();
        CollegeResponse collegeResponse = await collegeService.updateCollege(event.collegeRequest);
        yield CollegeAdded(collegeResponse: collegeResponse);
      }
      else if (event is CreateCollegeButtonPressed){
        yield CollegeLoading();
        CollegeResponse collegeResponse = await collegeService.createCollege(event.collegeRequest);
        yield CollegeAdded(collegeResponse: collegeResponse);
      }
      //todo remove from colleges list once deleted
      else if (event is DeleteCollege){
        yield CollegeLoading();
        CollegesResponse collegeResponse = await collegeService.getCollegeS();
        yield CollegeAbsent();
      }else if (event is CloseCollege) {
        yield CollegeAbsent();
      }
    }catch (error) {
      yield CollegeError(error: error.toString());
    }
  }


}