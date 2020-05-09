import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/colleges/bloc.dart';
import 'package:ums_flutter/models/response/college_response.dart';
import 'package:ums_flutter/utils/sizeConfig.dart';
import 'package:ums_flutter/components/drawer/Side_drawer.dart';

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
  bool show;

  changeState(CollegeResponse collegeResponse) {
    setState(() {
      show = !show;
    });
  }

  @override
  void initState() {
    super.initState();
    show = false;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: widget.sideDrawer,
      //todo when usertype == admin
      floatingActionButton: !show
          ? new FloatingActionButton.extended(
              backgroundColor: Color(0xFFFD3664),
              icon: Icon(Icons.add),
              label: Text(
                'Add College',
                style: TextStyle(
                    fontFamily: 'Oswald',
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/AddCollegeScreen');
              },
            )
          : null,
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
      //todo refactor stack with bottom navigation sheet
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
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
                        child: Column(
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
                BlocConsumer<CollegesBloc, CollegesState>(
                  listener: (context, state) {
                    if (state is CollegesLoadError) {
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
                        padding: EdgeInsets.all(18),
                        child: Column(
                            children:
                                _collegesList(state.collegesResponse, context)),
                      );
                    } else if (state is CollegesLoadInProgress) {
                      return LinearProgressIndicator(backgroundColor: Colors.black.withRed(50),
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),);
                    } else {
                      return Container(
                        height: 0,
                        width: 0,
                      );
                    }
                  },
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //todo refactor content display
  List<Widget> _collegesList(
      List<CollegeResponse> collegesResponse, BuildContext context) {
    List<Widget> list = new List<Widget>();
    for (var college in collegesResponse) {
      list.add(
        GestureDetector(
          onVerticalDragEnd: (val) {
            BlocProvider.of<CollegesBloc>(context).add(CollegesUpdated());
          },
          onTap: () =>
              Navigator.of(context).push(
                new CupertinoPageRoute(
                    builder: (BuildContext context) =>
                    new DetailedCollegeScreen(sideDrawer:widget.sideDrawer, collegeResponse: college,)
                ),),
          child: Column(
            children: <Widget>[
              Container(
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
                      "${college.code}",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFFD3664)),
                    ),
                    Text(
                      "${college.name}",
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
              SizedBox(height: 10)
            ],
          ),
        ),
      );
    }
    return list;
  }
}
