import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/bloc.dart';
import 'package:ums_flutter/components/components.dart';
import 'package:ums_flutter/models/models.dart';
import 'package:ums_flutter/screens/screens.dart';
import 'package:ums_flutter/utils/constants.dart';

class DetailedCourseScreen extends StatefulWidget {
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
  _DetailedCourseScreenState createState() => _DetailedCourseScreenState();
}

class _DetailedCourseScreenState extends State<DetailedCourseScreen> {
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  Completer<void> _refreshCompleter = Completer<void>();

  @override
  Widget build(BuildContext context) {
    CourseResponse _courseResponse = widget.courseResponse;
    return Scaffold(
      drawer: widget.sideDrawer,
      backgroundColor: Colors.black,
      floatingActionButton: CustomFloatingActionButton(
          icon: Icon(Icons.add, color: Colors.white),
          label: "Add Batch",
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context) => new AddBatchScreen(
                  sideDrawer: widget.sideDrawer,
                  courseID: _courseResponse.id,
                ),
              ),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: SafeArea(
        child: RefreshIndicator(
          color: Colors.red,
          backgroundColor: Color.fromARGB(254, 54, 54, 54),
          onRefresh: () {
            //todo do changes

            Future.delayed(const Duration(seconds: 2), () {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
            });
            return _refreshCompleter.future;
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              margin: EdgeInsets.all(SIDE_MARGIN),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      TopLogoHeader(),
                      PageHeader(
                        line1: widget.collegeCode,
                        marginTop: 5,
                        marginBottom: 5,
                      ),
                    ],
                  ),
                  BlocConsumer<CourseBloc, CourseState>(
                    listener: (BuildContext context, state) {
                      if (state is CourseLoadError) {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${state.error}'),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is CourseLoadSuccess) {
                        CourseResponse course = state.courseResponse;
                        return Column(
                          children: <Widget>[
                            _cardView(course),
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
                            _batchList(course, context)
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            _cardView(widget.courseResponse),
                            CustomCircularProgress(
                              label: "Loading Batches",
                            ),
                          ],
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardView(CourseResponse courseResponse) {
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
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      Navigator.of(context).push(
                        new CupertinoPageRoute(
                          builder: (BuildContext context) =>
                              AddEditCourseScreen(
                            sideDrawer: widget.sideDrawer,
                            collegeName: widget.collegeName,
                            collegeCode: widget.collegeCode,
                            collegeId: widget.collegeId,
                            isEditing: true,
                            courseResponse: courseResponse,
                          ),
                        ),
                      );
                    },
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

  Widget _batchList(CourseResponse courseResponse, BuildContext context) {
    List<BatchResponse> batches = courseResponse.batches;
    List<Widget> list = new List<Widget>();
    if (batches.isEmpty) {
      list.add(
        Center(
          child: Text(
            "No Batch is present yet...!\nPlease add a new batch.",
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
      batches.asMap().forEach(
            (index, batch) => list.add(
              SingleItemCard(
                label: batch.name,
                onTap: () {
                  HapticFeedback.lightImpact();
                  Navigator.of(context).push(
                    new CupertinoPageRoute(
                      builder: (BuildContext context) =>
                          new DetailedBatchScreen(
                              collegeCode: widget.collegeCode,
                              index: index,
                              courseResponse: courseResponse,
                              sideDrawer: widget.sideDrawer),
                    ),
                  );
                },
              ),
            ),
          );
    }
    return Column(children: list);
  }
}
