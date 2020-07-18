import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/components/components.dart';
import 'package:ums_flutter/models/models.dart';
import 'package:ums_flutter/screens/screens.dart';
import 'package:ums_flutter/utils/utils.dart';

class DetailedSectionScreen extends StatefulWidget {
  final SemesterResponse semesterResponse;
  final String collegeCode;
  final SideDrawer sideDrawer;
  final SectionResponse sectionResponse;

  const DetailedSectionScreen({
    Key key,
    @required this.semesterResponse,
    @required this.collegeCode,
    @required this.sideDrawer,
    @required this.sectionResponse,
  })  : assert(sideDrawer != null),
        assert(collegeCode != null),
        assert(semesterResponse != null),
        assert(sectionResponse != null),
        super(key: key);

  @override
  _DetailedSectionScreenState createState() => _DetailedSectionScreenState();
}

class _DetailedSectionScreenState extends State<DetailedSectionScreen> {
  bool subjectVisibility;
  bool sectionVisibility;

  @override
  void initState() {
    super.initState();
    subjectVisibility = false;
    sectionVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: widget.sideDrawer,
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
                _cardView(),
                SizedBox(height: 12),
                Center(
                  child: Container(
                    height: 36,
                    child: Text(
                      'Groups',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFFD3664)),
                    ),
                  ),
                ),
                SizedBox(height: 9),
                _groupView(widget.sectionResponse.groups),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardView() {
    List<String> semDetails = widget.semesterResponse.name.split(":");
    return Column(
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
                  "Section - ",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                Text(
                  "${widget.sectionResponse.name}",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFD3664),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
        Divider(
          thickness: 1,
          color: Color(0xCCFD3664),
        ),
      ],
    );
  }

  Widget _groupView(List<GroupResponse> groupResponse) {
    if (groupResponse.isEmpty) {
      return Center(
        child: Text(
          "No Group is present yet...!\nPlease add a new batch.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white38,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 9,
        crossAxisSpacing: 9,
        primary: false,
        children: new List<Widget>.generate(
          groupResponse.length,
          (index) => GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              Navigator.of(context).push(
                new CupertinoPageRoute(
                  builder: (BuildContext context) => new DetailedGroupScreen(
                    semesterResponse: widget.semesterResponse,
                    collegeCode: widget.collegeCode,
                    sideDrawer: widget.sideDrawer,
                    sectionResponse: widget.semesterResponse.sections[index],
                    groupResponse: groupResponse[index],
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
                    "${groupResponse[index].name}",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color(0xFFFD3664),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Mentor: Aditya",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                  Row(
                    children: [
                      Text(
                        "Students: ",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white54,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1),
                      ),
                      Text(
                        "30",
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
        ),
      );
    }
  }
}
