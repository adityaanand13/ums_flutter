import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/bloc.dart';
import 'package:ums_flutter/components/card/card.dart';
import 'package:ums_flutter/components/components.dart';
import 'package:ums_flutter/components/header/page_header.dart';
import 'package:ums_flutter/models/response/batch_response.dart';
import 'package:ums_flutter/models/response/course_response.dart';
import 'package:ums_flutter/components/drawer/side_drawer.dart';
import 'package:ums_flutter/models/response/semester_response.dart';
import 'package:ums_flutter/screens/screens.dart';
import 'package:ums_flutter/utils/constants.dart';

class DetailedBatchScreen extends StatelessWidget {
  final SideDrawer sideDrawer;
  final CourseResponse courseResponse;
  final String collegeCode;
  final int index;

  const DetailedBatchScreen({
    Key key,
    @required this.sideDrawer,
    @required this.courseResponse,
    @required this.collegeCode,
    @required this.index,
  })  : assert(sideDrawer != null),
        assert(courseResponse != null),
        assert(index != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> batchName = courseResponse.batches[index].name.split(":");
    return Scaffold(
      drawer: sideDrawer,
      backgroundColor: Colors.black,
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(SIDE_MARGIN),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TopLogoHeader(),
                _dataPresent(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dataPresent(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            _cardView(),
            SizedBox(height: 10),
            Center(
              child: Container(
                height: 36,
                child: Text(
                  'Semesters',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFD3664)),
                ),
              ),
            ),
            SizedBox(height: 10),
            _semesterList(courseResponse.batches[index], context),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ],
    );
  }

  Widget _cardView() {
    List<String> batchName = courseResponse.batches[index].name.split(":");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        PageHeader(
          line1: collegeCode,
          marginTop: 5,
          marginBottom: 5,
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              "Course: ",
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1),
            ),
            Text(
              "${batchName[0]}",
              style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFFFD3664),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Batch  : ",
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1),
            ),
            Text(
              "${batchName[1]}",
              style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFFFD3664),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1),
            ),
          ],
        ),
        SizedBox(height: 10),
        Divider(
          thickness: 1,
          color: Color(0xCCFD3664),
        ),
      ],
    );
  }

  Widget _semesterList(BatchResponse batchResponse, BuildContext context) {
    List<SemesterResponse> semesters = batchResponse.semesters;
    List<Widget> list = new List<Widget>();
    if (semesters.isEmpty) {
      list.add(
        Center(
          child: Text(
            "No batch is present yet...!\nPlease add a new batch.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white38,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else {
      semesters.asMap().forEach(
            (index, semester) => semester.active
                ? list.add(
                    TwoColumnCard(
                      header: "${semester.seq}",
                      label: semester.name,
                      item1: "Subjects: ${semester.subjects.length}",
                      item2: "Sections: ${semester.sections.length}",
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Navigator.of(context).push(
                          new CupertinoPageRoute(
                            builder: (BuildContext context) =>
                                DetailedSemesterScreen(
                              semesterResponse: semester,
                              collegeCode: collegeCode,
                              sideDrawer: sideDrawer,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : list.add(
                    TwoColumnCard(
                      onLongPress: () {
                        _longPressAction(context, semester.id, semester.name);
                      },
                      header: "${semester.seq}",
                      label: semester.name,
                      item1: "Not Active",
                    ),
                  ),
          );
    }
    return Column(children: list);
  }

  _longPressAction(BuildContext context, int id, String name) {
    HapticFeedback.lightImpact();
    Future.delayed(const Duration(milliseconds: 50), () {
      HapticFeedback.lightImpact();
    });
    customButtonDialog(
      context: context,
      header: "Activate",
      data: "Would you like to activate semester $name?",
      buttonLabel: "Yes",
      onPressed: () {
        BlocProvider.of<SemesterBloc>(context)
          ..add(SemesterActivate(
              id: id, batchId: courseResponse.batches[index].id));
        HapticFeedback.lightImpact();
        Navigator.of(context).pop();
        AlertDialog alert = AlertDialog(
            backgroundColor: Colors.white,
            content: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircularProgressIndicator(),
                Container(
                    child: Text(
                  "Activating ...",
                  style: TextStyle(color: Colors.red, fontSize: 18),
                )),
              ],
            ));
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
        //todo bloc connect
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pop();
        });
      },
    );
  }
}
