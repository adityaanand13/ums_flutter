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
import 'package:ums_flutter/models/response/semester_response.dart';
import 'package:ums_flutter/screens/batch/add_batch_screen.dart';
import 'package:ums_flutter/screens/courses/add_course_screen.dart';

class DetailedBatchScreen extends StatelessWidget {
  final SideDrawer sideDrawer;
  final CourseResponse courseResponse;
  final String collegeCode;
  final String collegeName;
  final int index;

  const DetailedBatchScreen({
    Key key,
    @required this.sideDrawer,
    @required this.courseResponse,
    @required this.collegeCode,
    @required this.collegeName,
    @required this.index,
  })  : assert(sideDrawer != null),
        assert(courseResponse != null),
        assert(index != null),
        assert(collegeName != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final rWidth = MediaQuery.of(context).size.width - 18 * 2;
    CourseResponse _courseResponse = courseResponse;
    return Scaffold(
      drawer: sideDrawer,
      backgroundColor: Colors.black,
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
                _dataPresent(rWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dataPresent(double rWidth) {
    return Column(
      children: <Widget>[
        _cardView(rWidth),
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
            _semesterList(courseResponse.batches[index], rWidth),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ],
    );
  }

  Widget _cardView(double rWidth) {
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

  Widget _semesterList(BatchResponse batchResponse, double rWidth) {
    List<SemesterResponse> semesters = batchResponse.semesters;
    List<Widget> list = new List<Widget>();
    if (semesters.isEmpty) {
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
      for (var semester in semesters) {
        list.add(
          GestureDetector(
            onTap: null,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF0D0D0D),
                border: Border.all(
                  color: Colors.white24,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(12),
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
                            "${semester.seq}",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFFD3664)),
                          ),
                          Text(
                            "${semester.name}",
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
                            'Sections: ${semester.sections.length}',
                            style: TextStyle(
                              fontFamily: 'Courier',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          Text('Subjects: ${semester.subjects.length}',
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
              )
            ),
          ),
        );
      }
    }
    return Column(children: list);
  }
}
