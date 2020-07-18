import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final Function onPressed;
  final Icon icon;
  final Color color;

  const CustomBottomNavigationBar({Key key, this.onPressed, this.icon, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              color: Colors.white,
              onPressed: () {
                HapticFeedback.lightImpact();
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          IconButton(
            icon: icon ?? Icon(Icons.search),
            color: color ?? Colors.white,
            onPressed: onPressed ?? () {
              HapticFeedback.lightImpact();
            },
          ),
        ],
      ),
      color: Color(0xff101010),
    );
  }
}
