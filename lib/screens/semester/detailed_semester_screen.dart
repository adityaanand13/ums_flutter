import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/components/components.dart';
import 'package:ums_flutter/models/models.dart';
import 'package:ums_flutter/screens/screens.dart';
import 'package:ums_flutter/utils/utils.dart';

class DetailedSemesterScreen extends StatefulWidget {
  final SemesterResponse semesterResponse;
  final String collegeCode;
  final SideDrawer sideDrawer;

  const DetailedSemesterScreen(
      {Key key,
      @required this.semesterResponse,
      @required this.collegeCode,
      @required this.sideDrawer})
      : assert(semesterResponse != null),
        assert(collegeCode != null),
        super(key: key);

  @override
  _DetailedSemesterScreenState createState() => _DetailedSemesterScreenState();
}

class _DetailedSemesterScreenState extends State<DetailedSemesterScreen>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: widget.sideDrawer,
      backgroundColor: Colors.black,
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: SafeArea(
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(child: _headerView()),
            ];
          },
          body: _tabView(),
        ),
      ),
    );
  }

  Widget _headerView() {
    List<String> semDetails = widget.semesterResponse.name.split(":");
    return Container(
      padding: EdgeInsets.all(SIDE_MARGIN),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TopLogoHeader(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: PageHeader(
                  line1: widget.collegeCode,
                  marginTop: 5,
                  marginBottom: 5,
                ),
              ),
              Text(
                "${semDetails[2]}",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFFFD3664),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${semDetails[0]}",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1),
                  ),
                  Text(
                    " : ",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1),
                  ),
                  Text(
                    "${semDetails[1]}",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        "Is Active: ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        "${widget.semesterResponse.active}",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFFD3664),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
//        Divider(
//          thickness: 1,
//          color: Color(0xCCFD3664),
//        ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tabView() {
    var tabBarItem = TabBar(
      labelColor: Colors.white,
      unselectedLabelColor: Color(0xFF606060),
      tabs: [
        Tab(
          text: "Sections",
        ),
        Tab(
          text: "Subject",
        ),
      ],
      indicatorPadding: EdgeInsets.symmetric(horizontal: 9),
      controller: _tabController,
      indicatorColor: Color(0xCCFD3664),
    );

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          tabBarItem,
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _sections(),
                _subject(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sections() {
    List<Widget> list = List<Widget>.generate(
      widget.semesterResponse.sections.length,
      (index) => GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          Navigator.of(context).push(
            new CupertinoPageRoute(
              builder: (BuildContext context) => new DetailedSectionScreen(
                semesterResponse: widget.semesterResponse,
                collegeCode: widget.collegeCode,
                sideDrawer: widget.sideDrawer,
                sectionResponse: widget.semesterResponse.sections[index],
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF0D0D0D),
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(9),
          ),
          padding: EdgeInsets.all(9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${widget.semesterResponse.sections[index].name}",
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFFFD3664),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "H. Mentor: Manish",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
              Row(
                children: [
                  Text(
                    "Groups: ",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white54,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1),
                  ),
                  Text(
                    "${widget.semesterResponse.sections[index].groups.length}",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    return Container(
      padding: EdgeInsets.all(9),
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 9,
        crossAxisSpacing: 9,
        primary: false,
        children: list,
      ),
    );
  }

  Widget _subject() {
    List<Widget> list = List<Widget>.generate(
      widget.semesterResponse.subjects.length,
      (index) => GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF0D0D0D),
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(9),
          ),
          padding: EdgeInsets.all(9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${widget.semesterResponse.subjects[index].name}",
                style: TextStyle(
                  fontSize: 25,
                  color: Color(0xFFFD3664),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${widget.semesterResponse.subjects[index].description}",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
              Row(
                children: [
                  Text(
                    "Detail: ",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white54,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                  Text(
                    "information!!",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    return Container(
      padding: EdgeInsets.all(9),
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 9,
        crossAxisSpacing: 9,
        primary: false,
        children: list,
      ),
    );
  }
}
