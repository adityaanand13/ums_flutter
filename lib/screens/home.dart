import 'package:flutter/material.dart';
import 'package:ums_flutter/widget/Side_drawer.dart';

class HomeScreen extends StatelessWidget {
  final SideDrawer sideDrawer;

  const HomeScreen({Key key, this.sideDrawer})
      : assert(sideDrawer != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: sideDrawer,
      body: Center(
        child: Text(
          "HomePage",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
        ),
      ),
    );
  }
}
