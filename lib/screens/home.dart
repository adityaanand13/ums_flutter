import 'package:flutter/material.dart';
import 'package:ums_flutter/components/components.dart';

class HomeScreen extends StatefulWidget {
  final SideDrawer sideDrawer;

  const HomeScreen({Key key, this.sideDrawer})
      : assert(sideDrawer != null),
        super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: widget.sideDrawer,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomFloatingActionButton(
        icon: Icon(Icons.sentiment_dissatisfied),
        label: "Display",
        onPressed: () => _scaffoldKey.currentState.showBottomSheet(
            (context) => BottomSheetInfo(
              buildContext: context,
              heading: "Information",
              actionLabel: "Close",
              information:
                  "लचकनहि प्रसारन हमारी कोहम असक्षम असरकारक मार्गदर्शन सदस्य पसंद विशेष संपुर्ण जानकारी पढाए पहोच। दिये संस्थान दस्तावेज पुर्णता मार्गदर्शन तरीके",
            ),
          backgroundColor: Colors.black12,
          ),

      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: Center(
        child: Text(
          "HomePage",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
        ),
      ),
    );
  }
}

//showModalBottomSheet(
//backgroundColor: Colors.transparent,
//isDismissible: false,
//isScrollControlled: false,
//context: context,
//builder: (BuildContext buildContext) => BottomSheetInfo(
//buildContext: buildContext,
//heading: "Information",
//actionLabel: "Close",
//information: "लचकनहि प्रसारन हमारी कोहम असक्षम असरकारक मार्गदर्शन सदस्य पसंद विशेष संपुर्ण जानकारी पढाए पहोच। दिये संस्थान दस्तावेज पुर्णता मार्गदर्शन तरीके",
//),
//),
