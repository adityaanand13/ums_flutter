import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final String line1;
  final String line2;
  final TextStyle line2Style;
  final double marginBottom;
  final double marginTop;

  const PageHeader({
    this.marginBottom,
    Key key,
    @required this.line1,
    this.line2,
    this.marginTop,
    this.line2Style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: marginTop ?? 20),
        Text(
          line1,
          style: TextStyle(
              fontSize: 32, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 5),
        line2 != null
            ? Text(
                line2,
                style: line2Style != null
                    ? line2Style
                    : TextStyle(
                        fontSize: 34,
                        color: Color(0xFFFD3664),
                        fontWeight: FontWeight.w600),
              )
            : Container(
                width: 0,
                height: 0,
              ),
        SizedBox(height: marginBottom ?? 20),
      ],
    );
  }
}
