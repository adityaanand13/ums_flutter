import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ums_flutter/utils/constants.dart';

class TwoColumnCard extends StatelessWidget {
  final Function onTap;
  final Function onLongPress;
  final String header;
  final String label;
  final String item1;
  final String item2;

  const TwoColumnCard(
      {Key key,
      this.onTap,
      this.onLongPress,
      @required this.header,
      this.label,
      @required this.item1,
      this.item2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.5),
      child: GestureDetector(
        onLongPress: onLongPress ?? null,
        onTap: onTap ?? null,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF0D0D0D),
            border: Border.all(
              color: Colors.white24,
            ),
            borderRadius: BorderRadius.circular(9),
          ),
          padding: EdgeInsets.all(9),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                width: (MediaQuery.of(context).size.width - 2 * SIDE_MARGIN - 20 ) * 0.68,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      header ?? "",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFFD3664)),
                    ),
                    label != null
                        ? Text(
                            label,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          )
                        : Container(
                            width: 0,
                            height: 0,
                          ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                width:
                    (MediaQuery.of(context).size.width - 2 * SIDE_MARGIN - 20) * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      item1 ?? "",
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    item2 != null
                        ? Text(
                            item2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Courier',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          )
                        : Container(
                            height: 0,
                            width: 0,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
