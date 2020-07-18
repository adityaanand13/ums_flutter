import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlatButtonCustom extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;
  final String title;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color color;
  final bool isEnabled;

  FlatButtonCustom({
    this.title,
    @required this.onTap,
    this.iconData,
    this.margin,
    this.color,
    this.isEnabled = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: margin ?? EdgeInsets.fromLTRB(0, 18, 0, 18),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          HapticFeedback.lightImpact();
          FocusScope.of(context).requestFocus(new FocusNode());
          if (isEnabled) {
            onTap();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: color ?? Color(0xFFFD3664),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: padding ?? EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (iconData != null)
                Icon(
                  iconData,
                  color: Colors.white,
                  size: 20,
                ),
              if (iconData != null)
                SizedBox(
                  width: 20,
                ),
              if (title != null)
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}