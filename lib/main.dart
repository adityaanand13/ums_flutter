import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/authentication_bloc.dart';
import 'package:ums_flutter/event_state/authentication/authentication_event.dart';
import 'package:ums_flutter/services/auth_service.dart';
import 'package:ums_flutter/services/user_service.dart';
import 'app.dart';


class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main(){
  //ensure only portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final authService = AuthService();
  final userService = UserService();
//  printData();
  runApp(
      BlocProvider<AuthenticationBloc>(
          create: (context) {
            return AuthenticationBloc(authService: authService)
              ..add(AppStarted());
          },
          child: MyApp(authService: authService, userService: userService,)
      )
  );
}


//Future<void> printData () async {
//  FlutterSecureStorage storage = FlutterSecureStorage();
//  CollegeApiProvider provider = CollegeApiProvider();
//  String token = await storage.read(key: "token");
//  //gets json
//  var collegeJson = await provider.get("1", token);
////  print(collegesJson);
////  collegesJson.forEach((college) => print(college));
////  print("\n");
////  print(collegesJson.runtimeType);
////  print(collegesJson[0].runtimeType);
////  List<CollegeResponse> colleges =  List<CollegeResponse>();
////  collegesJson.forEach((college) => colleges.add(CollegeResponse.fromJsonMap(college)));
//CollegeResponse collegeResponse = CollegeResponse.fromJsonMap(collegeJson);
//print(collegeResponse.name);
////print(collegeResponse.courses[0].runtimeType);
////List<CourseResponse> courseResponses = List<CourseResponse>();
////collegeResponse.courses.forEach((course) => courseResponses.add(CourseResponse.fromJsonMap(course)));
////CourseResponse courseResponse = CourseResponse.fromJsonMap(collegeResponse.courses[0]);
//CourseResponse courseResponse = collegeResponse.courses[0];
//print(courseResponse.name);
//
//
//
// //var response = await http.get("http://localhost:8080/api/user/", headers: headers);
//  //print(token);
//  //var user = coll.fromJsonMap(json.decode(response.body)['data']);
//  //print(user.username);
//  //print(json.decode(response.body));
//}