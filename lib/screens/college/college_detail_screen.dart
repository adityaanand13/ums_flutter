import 'package:flutter/material.dart';
import 'package:ums_flutter/widget/Side_drawer.dart';

class CollegeDetailScreen extends StatelessWidget {
  final SideDrawer sideDrawer;

  const CollegeDetailScreen({Key key, this.sideDrawer})
      : assert(sideDrawer != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("College Detail"),
      ),
      drawer: sideDrawer,
      floatingActionButton: new FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Add Course'),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.fromLTRB(22, 0, 22, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[Text("Option 1"), Text("option 2"),],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(22),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Detail 1 :"),
                  Text("Value"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Detail 2 :"),
                  Text("Value"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Detail 3 :"),
                  Text("Value"),
                ],
              ),
              Divider(),
              Column(children: [
                Text("Listed Detailed Titled"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Header 1 :"),
                    Text("Header 2"),
                    Text("Header 3"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Value 1 :"),
                    Text("value 2"),
                    Text("Value 3"),
                  ],
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
