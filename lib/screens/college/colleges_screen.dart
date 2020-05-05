import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/college_bloc.dart';
import 'package:ums_flutter/bloc/colleges_bloc.dart';
import 'package:ums_flutter/event_state/college/college_state.dart';
import 'package:ums_flutter/event_state/colleges/colleges_event.dart';
import 'package:ums_flutter/event_state/colleges/colleges_state.dart';
import 'package:ums_flutter/models/response/college_response.dart';
import 'package:ums_flutter/models/response/college_s_response.dart';
import 'package:ums_flutter/screens/college/single_college_view.dart';
import 'package:ums_flutter/utils/sizeConfig.dart';
import 'package:ums_flutter/components/drawer/Side_drawer.dart';

class CollegesScreen extends StatefulWidget {
  final SideDrawer sideDrawer;

  const CollegesScreen({Key key, this.sideDrawer})
      : assert(sideDrawer != null),
        super(key: key);

  @override
  _CollegesScreenState createState() => _CollegesScreenState();
}

class _CollegesScreenState extends State<CollegesScreen> {
  void _refresh(BuildContext context) {
    BlocProvider.of<CollegesBloc>(context).add(GetCollegeS());
  }

  changeState(CollegeResponse collegeResponse) {
    setState(() {
      show = !show;
    });
  }

  bool show = false;
  CollegeResponse collegeResponse = null;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: widget.sideDrawer,
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
                        return Container(
                          padding: EdgeInsets.all(18),
                          child: Column(
                              children: _collegesList(
                                  state.collegesResponse, context)),
                        );
                      } else if (state is CollegesAbsent) {
                        BlocProvider.of<CollegesBloc>(context)
                            .add(GetCollegeS());
                        return Center(
                            child: Container(
                          width: 0.0,
                          height: 0.0,
                        ));
                      } else if (state is CollegesLoading) {
                        return Center(
                          child: LinearProgressIndicator(),
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
            ),
          ),
          show
              ? CollegeView(
                  collegeResponse: collegeResponse,
                  changeState: changeState,
                  sideDrawer: widget.sideDrawer,
                )
              : Container(
                  height: 0,
                  width: 0,
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
          onTap: () {
            collegeResponse = college;
            changeState(college);
          },
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
