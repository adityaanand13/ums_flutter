import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/bloc.dart';
import 'package:ums_flutter/components/components.dart';
import 'package:ums_flutter/models/models.dart';
import 'package:ums_flutter/screens/screens.dart';

import 'detailed_college_screen.dart';

class CollegesScreen extends StatefulWidget {
  final SideDrawer sideDrawer;

  const CollegesScreen({Key key, this.sideDrawer})
      : assert(sideDrawer != null),
        super(key: key);

  @override
  _CollegesScreenState createState() => _CollegesScreenState();
}

class _CollegesScreenState extends State<CollegesScreen> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: widget.sideDrawer,
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          HapticFeedback.lightImpact();
          Navigator.of(context).push(
            new CupertinoPageRoute(
              builder: (BuildContext context) =>
                  new AddEditCollegeScreen(sideDrawer: widget.sideDrawer),
            ),
          );
        },
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: 'Add College',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: RefreshIndicator(
        color: Colors.red,
        backgroundColor: Color.fromARGB(254, 54, 54, 54),
        onRefresh: () {
          BlocProvider.of<CollegesBloc>(context)..add(CollegesUpdated());
          return _refreshCompleter.future;
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ImagedHeader(
                  header1: "Colleges", header2: "MMDU", header3: "Mullana"),
              BlocConsumer<CollegesBloc, CollegesState>(
                listener: (context, state) {
                  if (state is CollegesLoadSuccess) {
                    _refreshCompleter?.complete();
                    _refreshCompleter = Completer();
                  } else if (state is CollegesLoadError) {
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
                  if (state is CollegesLoadSuccess) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      child: state.collegesResponse.length != 0
                          ? Column(
                              children: _collegesList(
                                  state.collegesResponse, context),
                            )
                          : Center(
                              child: Text(
                                "No College has been added...!\nPlease add a new College.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white38,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                    );
                  } else if (state is CollegesLoadInProgress) {
                    return LinearProgressIndicator(
                      backgroundColor: Colors.black.withRed(50),
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                    );
                  } else {
                    return Container(
                      height: 0,
                      width: 0,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //todo refactor content display
  List<Widget> _collegesList(
      List<CollegeResponse> collegesResponse, BuildContext context) {
    List<Widget> list = new List<Widget>();
    for (var college in collegesResponse) {
      list.add(
        OneColumnCard(
          header: college.code,
          label: college.name,
          onTap: () {
            HapticFeedback.lightImpact();
            Navigator.of(context).push(
              new CupertinoPageRoute(
                builder: (BuildContext context) => new DetailedCollegeScreen(
                  sideDrawer: widget.sideDrawer,
                  collegeResponse: college,
                ),
              ),
            );
          },
        ),
      );
    }
    return list;
  }
}
