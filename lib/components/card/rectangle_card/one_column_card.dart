import 'package:flutter/material.dart';

class OneColumnCard extends StatelessWidget {
  final Function onTap;
  final String header;
  final String label;

  const OneColumnCard({Key key, this.onTap, @required this.header, @required  this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.5),
      child: GestureDetector(
        onTap: onTap,
        child:Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFF0D0D0D),
            border: Border.all(
              color: Colors.white24,
            ),
            borderRadius: BorderRadius.circular(9),
          ),
          padding: EdgeInsets.all(9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(header ?? "!!",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFFD3664)),
              ),
              Text(label ?? "!!",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
