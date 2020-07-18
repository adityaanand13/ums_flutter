import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ums_flutter/utils/constants.dart';

void customButtonDialog({
  @required BuildContext context,
  @required String header,
  String data,
  String buttonLabel,
  @required Function onPressed,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SIDE_MARGIN),
              color: Color.fromRGBO(16, 16, 16, 1),
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(SIDE_MARGIN),
                        topRight: Radius.circular(SIDE_MARGIN)),
                    color: Color.fromRGBO(32, 32, 32, 1),
                  ),
                  height: 90,
                  padding: EdgeInsets.all(SIDE_MARGIN),
                  child: Center(
                    child: Text(
                      header,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(SIDE_MARGIN),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SIDE_MARGIN),
                    color: Color.fromRGBO(16, 16, 16, 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data ?? "",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: RaisedButton(
                          color: Colors.lightGreen,
                          child: Text(
                            buttonLabel ?? "Continue",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            onPressed();
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
