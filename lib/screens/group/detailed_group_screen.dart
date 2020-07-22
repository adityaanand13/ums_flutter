import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/components/components.dart';
import 'package:ums_flutter/models/models.dart';
import 'package:ums_flutter/screens/group/add_student_screen.dart';
import 'package:ums_flutter/utils/utils.dart';

class DetailedGroupScreen extends StatefulWidget {
  final SemesterResponse semesterResponse;
  final String collegeCode;
  final SideDrawer sideDrawer;
  final SectionResponse sectionResponse;
  final GroupResponse groupResponse;

  const DetailedGroupScreen({
    Key key,
    @required this.semesterResponse,
    @required this.collegeCode,
    @required this.sideDrawer,
    @required this.sectionResponse,
    @required this.groupResponse,
  })  : assert(sideDrawer != null),
        assert(collegeCode != null),
        assert(semesterResponse != null),
        assert(sectionResponse != null),
        assert(groupResponse != null),
        super(key: key);

  @override
  _DetailedGroupScreenState createState() => _DetailedGroupScreenState();
}

class _DetailedGroupScreenState extends State<DetailedGroupScreen> {
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
      floatingActionButton: CustomFloatingActionButton(
          icon: Icon(Icons.add, color: Colors.white),
          label: "Add Student",
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context) => new AddStudentScreen(
                  sideDrawer: widget.sideDrawer,
                  groupId: widget.groupResponse.id,
                ),
              ),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                      'Students',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFFD3664)),
                    ),
                  ),
                ),
                SizedBox(height: 9),
                _studentPageView(widget.sectionResponse.groups),
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
        //Semester name + Batch name
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${semDetails[2]}",
              textAlign: TextAlign.left,
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
          ],
        ),
        //Section name
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  "Section  ",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                Text(
                  "${widget.sectionResponse.name}",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFD3664),
                  ),
                ),
              ],
            ),
          ],
        ),
        //Group Name
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  "Group    ",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                Text(
                  "${widget.groupResponse.name}",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFD3664),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 9,
          crossAxisSpacing: 16,
          primary: false,
          children: [
            ProfileImageCard(
              header: "Head Mentor",
              detail1: "Yagani Yadav",
              detail2Label: "Id: ",
              detail2: "1317056",
              onTap: () {
                HapticFeedback.lightImpact();
                Future.delayed(const Duration(milliseconds: 150), () {
                  HapticFeedback.lightImpact();
                });
              },
            ),
            ProfileImageCard(
              header: "Group Mentor",
              detail1: "Yagani Yadav",
              detail2Label: "Id",
              detail2: "1317056",
              onTap: () {
                HapticFeedback.lightImpact();
                Future.delayed(const Duration(milliseconds: 150), () {
                  HapticFeedback.lightImpact();
                });
              },
            ),
          ],
        ),
        SizedBox(height: 16),
        Divider(
          height: 0,
          thickness: 1,
          color: Color(0xCCFD3664),
        ),
      ],
    );
  }

  Widget _studentPageView(List<GroupResponse> groupResponse) {
    return Center(
      child: Text(
        "No Student is added yet...!\n",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white38,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
