import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/college_bloc.dart';
import 'package:ums_flutter/bloc/colleges_bloc.dart';
import 'package:ums_flutter/bloc/navigation_bloc.dart';
import 'package:ums_flutter/event_state/college/college_event.dart';
import 'package:ums_flutter/event_state/college/college_state.dart';
import 'package:ums_flutter/event_state/colleges/colleges_event.dart';
import 'package:ums_flutter/event_state/colleges/colleges_state.dart';
import 'package:ums_flutter/models/response/college_response.dart';
import 'package:ums_flutter/models/response/college_s_response.dart';
import 'package:ums_flutter/utils/sizeConfig.dart';

class HomeScreen extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(16, 16, 16, 1),
      //todo add a blockBuilder
      //if ( stat is Display College) then pen color green
      //on press - chnage event to edit
      //if state is coleges then diplay add icon  color blue
      //change event to create college
      //if state is edit then display tick green
      //chnage event to create college
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: null,
      ),
      body:  Stack(
        children: <Widget>[SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: SizeConfig.blockSizeVertical * 45,
                  width: SizeConfig.screenWidth,
                  child: Stack(
                    children: <Widget>[
                      ShaderMask(
                        shaderCallback: (rect) {
                          return LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.black, Colors.transparent])
                              .createShader(
                                  Rect.fromLTRB(0, 0, rect.width, rect.height));
                        },
                        blendMode: BlendMode.dstIn,
                        //todo change image
                        child: Image.asset('images/university.jpg',
                            alignment: Alignment.topCenter,
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.blockSizeVertical * 45,
                            fit: BoxFit.fill),
                      ),
                      Positioned(
                        bottom: SizeConfig.blockSizeVertical * 2,
                        left: 12,
                        child:
                            //todo add a blockBuilder
                            //if ( state is EditCollege || Display College)
                            Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Colleges',
                              style: TextStyle(
                                  fontFamily: 'Oswald',
                                  fontSize: SizeConfig.blockSizeHorizontal * 9,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            Row(
                              children: <Widget>[
                                Text('MMDU',
                                    style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal * 10,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFFD3664))),
                                Text(',',
                                    style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal * 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                SizedBox(width: 10.0),
                                Text(
                                  'Mullana',
                                  style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ), //move to a function
                      ),
                    ],
                  ),
                ),
                BlocListener<CollegesBloc, CollegesState>(
                  listener: (context, state) {
                    if (state is CollegesError) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${state.error}'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<CollegesBloc, CollegesState>(
                    builder: (context, state) {
                      if (state is CollegesPresent) {
                        return Column(
                            children:
                                _collegesList(state.collegesResponse, context));
                      } else if (state is CollegesAbsent) {
                        BlocProvider.of<CollegesBloc>(context)
                            .add(GetCollegeS());
                        return Center(
                          child: Text("hello"),
                        );
                      } else if (state is CollegesLoading) {
                        return Center(
                          child: Text("hello"),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 8,
                ),
              ],
            ),),
            BlocListener<CollegeBloc, CollegeState>(
              listener: (context, state) {
                if (state is CollegeError) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${state.error}',
                      style: TextStyle(
                        color: Colors.green,
                      ),),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              child: BlocBuilder<CollegeBloc, CollegeState>(
                // ignore: missing_return, missing_return
                builder: (context, state) {
                  if (state is CollegePresent) {
                    print("Kahe pareshan ho rahe ho");
                    return showCollege(context, state.collegeResponse);
                  } else if (state is CollegeAbsent) {
                    return Container(
                        child: SizedBox.shrink()
                    );
                  } else if (state is CollegeLoading) {
                    return Center(child: Text("Load nhi lena bhai"));
                  } else if (state is EditCollege) {
                    return Center(child: Text("Error aaya bhai"));
                  }
                },
              ),
            ),
          ],
        ),

    );
  }

  //todo refactor content display
  List<Widget> _collegesList(
      CollegesResponse collegesResponse, BuildContext context) {
    List<Widget> list = new List<Widget>();
    for (var college in collegesResponse.colleges) {
      list.add(
        GestureDetector(
          onTap: () => BlocProvider.of<CollegeBloc>(context)
              .add(GetCollege(id: college.id)),
          child: Column(
            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.all(5),
                title: Text(
                  'MMICT&BM',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.blockSizeHorizontal * 4,
                      fontWeight: FontWeight.w800),
                ),
                subtitle: Text(
                  'M.M Institute Of Computer technology & Bussiness Management',
                  style: TextStyle(
                    color: Color(0xFF1BB5FD),
                    fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                  ),
                ),
                leading: CircleAvatar(
                  child: Icon(
                    Icons.perm_identity,
                    color: Colors.white,
                  ),
                  radius: 40,
                ),
              ),
              Divider(
                height: SizeConfig.blockSizeVertical * 2.5,
                thickness: 0.5,
                color: Colors.white.withOpacity(0.3),
                indent: 32,
                endIndent: 32,
              ),
            ],
          ),
        ),
      );
    }
    return list;
  }
}

Widget showCollege(context, CollegeResponse collegeResponse) {
  //todo add back button in container above row row mainAxisAlgnment.
  //todo add extra 3 outline buttons at bottom
  return Container(
        //todo refactor with sizeConfig
        height: SizeConfig.blockSizeVertical * 10,
        width: SizeConfig.blockSizeHorizontal * 8,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(height: 150.0),
                Container(
                  height: 100.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      color: Colors.teal),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  collegeResponse.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Quicksand',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                  ),
                )),
            SizedBox(height: 20.0),
            Padding(
                padding: EdgeInsets.only(left: 1.0),
                child: Text(
                  collegeResponse.description,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Quicksand',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                  ),
                )),
            SizedBox(height: 8.0),
            Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  collegeResponse.code,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Quicksand',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                  ),
                )),
            SizedBox(height: 8.0),
            Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  collegeResponse.address,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Quicksand',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                  ),
                )),
            SizedBox(height: 15.0),
            FloatingActionButton(
                tooltip: "Edit College",
                backgroundColor: Colors.blue,
                child: new ListTile(
                  title: new Icon(
                    Icons.edit,
                  ),
                ),
                onPressed: () {
//                          Navigator.of(context).pushReplacementNamed('/signup');
                }),

//                    FlatButton(
//                        child: Center(
//                          child: Text(
//                            'OKAY',
//                            style: TextStyle(
//                                fontFamily: 'Montserrat',
//                                fontSize: 14.0,
//                                color: Colors.teal),
//                          ),
//                        ),
//                        onPressed: () {
//                          Navigator.of(context).pop();
//                        },
//                        color: Colors.transparent
//                    )
          ],
        ),
      );
}

//todo create a college display

//todo create a college edit

//todo create a delete confirmation
