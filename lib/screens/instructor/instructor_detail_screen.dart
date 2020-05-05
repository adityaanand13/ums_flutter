import 'package:flutter/material.dart';
import 'package:ums_flutter/models/instructor_model.dart';
import 'package:ums_flutter/components/drawer/Side_drawer.dart';

class InstructorDetailScreen extends StatefulWidget {
  final InstructorModel instructor;
  final SideDrawer sideDrawer;

  const InstructorDetailScreen({Key key, @required this.instructor, @required this.sideDrawer})
      : assert(instructor != null),
        assert(sideDrawer != null),
        super(key: key);

  @override
  _InstructorDetailScreenState createState() => _InstructorDetailScreenState();
}

class _InstructorDetailScreenState extends State<InstructorDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('${widget.instructor.username}'),
            Text('${widget.instructor.firstName}'),
            Text('${widget.instructor.lastName}'),
            Text('${widget.instructor.aadhar}'),
            Text('${widget.instructor.email}'),
          ],
        ),
      ),
    );
  }
}
