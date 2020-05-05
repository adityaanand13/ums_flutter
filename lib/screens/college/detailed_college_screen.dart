import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/college_bloc.dart';
import 'package:ums_flutter/event_state/college/college_event.dart';
import 'package:ums_flutter/event_state/college/college_state.dart';
import 'package:ums_flutter/models/response/college_response.dart';
import 'package:ums_flutter/models/response/course_response.dart';
import 'package:ums_flutter/components/drawer/Side_drawer.dart';
import 'package:ums_flutter/screens/courses/add_course_screen.dart';
import 'package:ums_flutter/screens/courses/detailed_course_screen.dart';
import 'package:ums_flutter/services/college_service.dart';

class DetailedCollegeScreen extends StatelessWidget {
  final SideDrawer sideDrawer;
  final CollegeResponse collegeResponse;

  const DetailedCollegeScreen({
    Key key,
    @required this.sideDrawer,
    @required this.collegeResponse,
  })  : assert(sideDrawer != null),
        assert(collegeResponse != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final rWidth = MediaQuery.of(context).size.width - 18 * 2;
    CollegeResponse _collegeResponse = collegeResponse;
    return Scaffold(
      drawer: sideDrawer,
      backgroundColor: Colors.black,
      floatingActionButton: new FloatingActionButton.extended(
        backgroundColor: Color(0xFFFD3664),
        icon: Icon(Icons.add),
        label: Text(
          'Add Course',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
        onPressed: () {
          Navigator.of(context).push(
            new MaterialPageRoute(
              builder: (BuildContext context) => new AddCourseScreen(
                sideDrawer: sideDrawer,
                collegeID: collegeResponse.id,
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu),
                color: Colors.white,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              color: Colors.white,
              onPressed: () {},
            ),
          ],
        ),
        color: Color(0xff101010),
      ),
      body: SafeArea(
        child: BlocListener<CollegeBloc, CollegeState>(
          listener: (BuildContext context, state) {
            if (state is CollegeError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.error}'),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                ),
              );
            }
          },
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Maharishi  Markandeshwar',
                        style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFFD3664)),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Deemed to be University',
                        style: TextStyle(
                            letterSpacing: 2,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Divider(
                        thickness: 1,
                        color: Color(0xCCFD3664),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                  BlocBuilder<CollegeBloc, CollegeState>(
                    builder: (context, state) {
                      if (state is CollegeLoading) {
                        return _dataAbsent(collegeResponse, rWidth);
                      } else if (state is CollegeAdded) {
                        if (_collegeResponse.id != state.collegeResponse.id) {
                          BlocProvider.of<CollegeBloc>(context)
                              .add(GetCollege(id: collegeResponse.id));
                          return Column(
                            children: <Widget>[
                              SizedBox(height: 10),
                              Center(child: CircularProgressIndicator()),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        } else {
                          _collegeResponse = state.collegeResponse;
                          return _dataPresent(
                              _collegeResponse, rWidth, context);
                        }
                      } else {
                        BlocProvider.of<CollegeBloc>(context)
                            .add(GetCollege(id: collegeResponse.id));
                        return _dataAbsent(collegeResponse, rWidth);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dataPresent(
      CollegeResponse collegeResponse, double rWidth, BuildContext context) {
    return Column(
      children: <Widget>[
        _cardView(collegeResponse, rWidth),
        Column(
          children: <Widget>[
            SizedBox(height: 8),
            Center(
              child: Container(
                height: 36,
                child: Text(
                  'COURSES',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFD3664)),
                ),
              ),
            ),
            SizedBox(height: 10),
            _courseList(collegeResponse, rWidth, context),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ],
    );
  }

  Widget _dataAbsent(CollegeResponse collegeResponse, double rWidth) {
    return Column(
      children: <Widget>[
        _cardView(collegeResponse, rWidth),
        Column(
          children: <Widget>[
            SizedBox(height: 8),
            Center(
              child: Container(
                height: 36,
                child: Text(
                  'COURSES',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFD3664)),
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(child: CircularProgressIndicator()),
            SizedBox(
              height: 10,
            ),
          ],
        )
      ],
    );
  }

  Widget _cardView(CollegeResponse collegeResponse, double rWidth) {
    return Column(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "${collegeResponse.code}",
                  style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFFFD3664),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1),
                ),
                ButtonTheme(
                  height: 20,
                  minWidth: 30,
                  child: OutlineButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 1,
                    ),
                    child: Text(
                      'Edit',
                      style: TextStyle(color: Colors.white54, fontSize: 15),
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
//                        SizedBox(height: 5),
            Text(
              "${collegeResponse.name}",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Principal",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFFFD3664),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Dr. Sumit Mittal",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "1417098",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: null,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.edit,
                            color: Colors.green,
                            size: 16,
                          ),
                          Text(
                            " EDIT",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Address",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFFFD3664),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "${collegeResponse.address}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Contact",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFFFD3664),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.phone,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${collegeResponse.phone}",
                      style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 3),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.email,
                      color: Colors.white70,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${collegeResponse.email}",
                      style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
            Divider(
              thickness: 1,
              color: Color(0xCCFD3664),
            ),
          ],
        ),
      ],
    );
  }

  Widget _courseList(
      CollegeResponse collegeResponse, double rWidth, BuildContext context) {
    List<CourseResponse> courses = collegeResponse.courses;
    List<Widget> list = new List<Widget>();
    if (courses.isEmpty) {
      list.add(Center(
        child: Text(
          "No course is present yet...!\nPlease add a new course.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white38,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
    } else {
      for (var course in courses) {
        list.add(GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context) => new DetailedCourseScreen(
                  sideDrawer: sideDrawer,
                  collegeId: collegeResponse.id,
                  courseResponse: course,
                  collegeCode: collegeResponse.code,
                  collegeName: collegeResponse.name,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF0D0D0D),
              border: Border.all(
                color: Colors.white24,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: (rWidth - 20) * 0.68,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${course.code}",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFFD3664)),
                      ),
                      Text(
                        "${course.name}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  width: (rWidth - 10) * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Duration: ${course.duration}',
                        style: TextStyle(
                          fontFamily: 'Courier',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      Text('Batches: \$\$',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
        list.add(SizedBox(height: 10));
      }
    }
    return Column(children: list);
  }
}
