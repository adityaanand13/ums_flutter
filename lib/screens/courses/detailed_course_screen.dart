import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/college_bloc.dart';
import 'package:ums_flutter/bloc/course_bloc.dart';
import 'package:ums_flutter/components/header/page_header.dart';
import 'package:ums_flutter/event_state/college/college_state.dart';
import 'package:ums_flutter/event_state/course/course_event.dart';
import 'package:ums_flutter/event_state/course/course_state.dart';
import 'package:ums_flutter/models/response/batch_response.dart';
import 'package:ums_flutter/models/response/course_response.dart';
import 'package:ums_flutter/components/drawer/Side_drawer.dart';
import 'package:ums_flutter/screens/courses/add_course_screen.dart';

class DetailedCourseScreen extends StatelessWidget {
  final SideDrawer sideDrawer;
  final CourseResponse courseResponse;
  final String collegeCode;
  final String collegeName;
  final int collegeId;

  const DetailedCourseScreen({
    Key key,
    @required this.sideDrawer,
    @required this.courseResponse,
    @required this.collegeCode,
    @required this.collegeName,
    @required this.collegeId,
  })  : assert(sideDrawer != null),
        assert(courseResponse != null),
        assert(collegeId != null),
        assert(collegeName != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final rWidth = MediaQuery.of(context).size.width - 18 * 2;
    CourseResponse _courseResponse = courseResponse;
    return Scaffold(
      drawer: sideDrawer,
      backgroundColor: Colors.black,
      floatingActionButton: new FloatingActionButton.extended(
        backgroundColor: Color(0xFFFD3664),
        icon: Icon(Icons.add),
        label: Text(
          'Add Batch',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
        onPressed: (){},
//            () {
//          Navigator.of(context).push(
//            new MaterialPageRoute(
//                builder: (BuildContext context) => new AddCourseScreen(
//                      sideDrawer: sideDrawer,
//                    ),
//            ),
//          );
//        },
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
                  PageHeader(
                    line1: collegeCode,
                    marginTop: 5,
                    marginBottom: 5,
                  ),
                  BlocBuilder<CourseBloc, CourseState>(
                    builder: (context, state) {
                      if (state is CourseLoading) {
                        return _dataAbsent(_courseResponse, rWidth);
                      } else if (state is CourseAdded) {
                        if (_courseResponse.id != state.courseResponse.id) {
                          BlocProvider.of<CourseBloc>(context)
                              .add(GetCourse(id: _courseResponse.id));
                          return _dataAbsent(_courseResponse, rWidth);
                        } else {
                          _courseResponse = state.courseResponse;
                          return _dataPresent(_courseResponse, rWidth);
                        }
                      } else {
                        BlocProvider.of<CourseBloc>(context)
                            .add(GetCourse(id: _courseResponse.id));
                        return _dataAbsent(courseResponse, rWidth);
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

  Widget _dataPresent(CourseResponse courseResponse, double rWidth) {
    return Column(
      children: <Widget>[
        _cardView(courseResponse, rWidth),
        Column(
          children: <Widget>[
            SizedBox(height: 8),
            Center(
              child: Container(
                height: 36,
                child: Text(
                  'BATCHES',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFD3664)),
                ),
              ),
            ),
            SizedBox(height: 10),
            _courseList(courseResponse, rWidth),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ],
    );
  }

  Widget _dataAbsent(CourseResponse courseResponse, double rWidth) {
    return Column(
      children: <Widget>[
        _cardView(courseResponse, rWidth),
        Column(
          children: <Widget>[
            SizedBox(height: 8),
            Center(
              child: Container(
                height: 36,
                child: Text(
                  'Batches',
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

  Widget _cardView(CourseResponse courseResponse, double rWidth) {
    return Column(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "${courseResponse.code}",
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
              "${courseResponse.name}",
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
                  "Description",
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
                  "${courseResponse.description}",
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
            Divider(
              thickness: 1,
              color: Color(0xCCFD3664),
            ),
          ],
        ),
      ],
    );
  }

  Widget _courseList(CourseResponse courseResponse, double rWidth) {
    List<BatchResponse> batches = courseResponse.batches;
    List<Widget> list = new List<Widget>();
    if (batches.isEmpty) {
      list.add(Center(
        child: Text(
          "No batch is present yet...!\nPlease add a new batch.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white38,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
    } else {
      for (var batch in batches) {
        list.add(
          GestureDetector(
            onTap: null,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF0D0D0D),
                border: Border.all(
                  color: Colors.white24,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${batch.name}",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFFD3664)),
                    ),
                    Text(
                      "${batch.description}",
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
          ),
        );
        list.add(SizedBox(height: 10));
      }
    }
    return Column(children: list);
  }
}
