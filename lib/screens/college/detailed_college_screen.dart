import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/bloc.dart';
import 'package:ums_flutter/components/components.dart';
import 'package:ums_flutter/models/models.dart';
import 'package:ums_flutter/screens/screens.dart';
import 'package:ums_flutter/utils/utils.dart';

class DetailedCollegeScreen extends StatefulWidget {
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
  _DetailedCollegeScreenState createState() => _DetailedCollegeScreenState();
}

class _DetailedCollegeScreenState extends State<DetailedCollegeScreen> {
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  Completer<void> _refreshCompleter = Completer<void>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: widget.sideDrawer,
      backgroundColor: Colors.black,
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          HapticFeedback.lightImpact();
          Navigator.of(context).push(
            new CupertinoPageRoute(
              builder: (BuildContext context) => AddEditCourseScreen(
                sideDrawer: widget.sideDrawer,
                collegeName: widget.collegeResponse.name,
                collegeCode: widget.collegeResponse.code,
                collegeId: widget.collegeResponse.id,
              ),
            ),
          );
        },
        icon: Icon(Icons.add, color: Colors.white),
        label: 'Add Course',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          color: Colors.red,
          backgroundColor: Color.fromARGB(254, 54, 54, 54),
          onRefresh: () {
            BlocProvider.of<CollegesBloc>(context)
                .add(CollegeFetch(collegeResponse: widget.collegeResponse));
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
                  TopLogoHeader(),
                  BlocBuilder<CollegesBloc, CollegesState>(
                    builder: (BuildContext context, CollegesState state) {
                      if (state is CollegesLoadSuccess) {
                        _refreshCompleter?.complete();
                        _refreshCompleter = Completer();
                        var college = state.collegesResponse.firstWhere(
                            (element) =>
                                widget.collegeResponse.id == element.id,
                            orElse: () => null);
                        if (college?.courses == null) {
                          BlocProvider.of<CollegesBloc>(context).add(
                              CollegeFetch(
                                  collegeResponse: widget.collegeResponse));
                          return Column(
                            children: [
                              _cardView(context, widget.collegeResponse, true),
                              CustomCircularProgress(
                                label: "Loading Courses",
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: <Widget>[
                              _cardView(context, college, false),
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
                              _courseList(college, context),
                            ],
                          );
                        }
                      } else {
                        return CustomCircularProgress(
                          label: "Loading Courses",
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

  Widget _courseList(CollegeResponse collegeResponse, BuildContext context) {
    List<CourseResponse> courses = collegeResponse.courses;
    List<Widget> list = new List<Widget>();
    if (courses.isEmpty) {
      list.add(
        Center(
          child: Text(
            "No course is present yet...!\nPlease add a new course.",
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
      for (var course in courses) {
        list.add(
          TwoColumnCard(
            onTap: () {
              HapticFeedback.lightImpact();
              BlocProvider.of<CourseBloc>(context)
                ..add(CourseLoadToUI(
                    courseResponse: course, collegeId: collegeResponse.id));
              Navigator.of(context).push(
                new CupertinoPageRoute(
                  builder: (BuildContext context) => new DetailedCourseScreen(
                    sideDrawer: widget.sideDrawer,
                    collegeId: collegeResponse.id,
                    courseResponse: course,
                    collegeCode: collegeResponse.code,
                    collegeName: collegeResponse.name,
                  ),
                ),
              );
            },
            header: "${course.code}",
            label: "${course.name}",
            item1: 'Duration: ${course.duration}',
            item2: 'Batches: ${course.batches.length}',
          ),
        );
      }
    }
    return Column(children: list);
  }

  Widget _cardView(
      BuildContext context, CollegeResponse collegeResponse, bool isLoading) {
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
                    onPressed: () {
                      Navigator.of(context).push(
                        new CupertinoPageRoute(
                          builder: (BuildContext context) =>
                              new AddEditCollegeScreen(
                            sideDrawer: widget.sideDrawer,
                            isEditing: true,
                            collegeResponse: collegeResponse,
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
                isLoading
                    ? LinearProgressIndicator()
                    : collegeResponse.principal != null
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "\\\\. ${collegeResponse.principal?.firstName} ${collegeResponse.principal?.lastName}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "${collegeResponse.principal?.username}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  Navigator.of(context).push(
                                    new CupertinoPageRoute(
                                      builder: (BuildContext context) =>
                                          new AssignEditPrincipalScreen(
                                        sideDrawer: widget.sideDrawer,
                                        collegeResponse: collegeResponse,
                                        isEditing: true,
                                      ),
                                    ),
                                  );
                                },
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
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Please assign a principal",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.yellow,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    new CupertinoPageRoute(
                                      builder: (BuildContext context) =>
                                          new AssignEditPrincipalScreen(
                                        sideDrawer: widget.sideDrawer,
                                        collegeResponse: collegeResponse,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.edit,
                                      color: Colors.yellowAccent,
                                      size: 16,
                                    ),
                                    Text(
                                      " EDIT",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.yellowAccent,
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
            SizedBox(height: 8),
          ],
        ),
      ],
    );
  }
}
