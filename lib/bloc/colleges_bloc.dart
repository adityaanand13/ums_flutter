import 'package:bloc/bloc.dart';
import 'package:ums_flutter/event_state/colleges/colleges_event.dart';
import 'package:ums_flutter/event_state/colleges/colleges_state.dart';
import 'package:ums_flutter/models/response/colleges_response.dart';
import 'package:ums_flutter/services/college_service.dart';

class CollegesBloc extends Bloc<CollegesEvent, CollegesState> {
  final CollegeService collegeService;

  CollegesBloc({this.collegeService}) : assert(collegeService != null);

  @override
  get initialState => CollegesAbsent();

  @override
  Stream<CollegesState> mapEventToState(CollegesEvent event) async* {
    try{
      if(event is GetCollegeS){
        yield CollegesLoading();
        CollegesResponse collegesResponse = await collegeService.getCollegeS();
        yield CollegesPresent(collegesResponse: collegesResponse);
      }
    }catch (error) {
      yield CollegesError(error: error.toString());
    }
  }


}