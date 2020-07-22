import 'package:flutter/material.dart';

class CustomCircularProgress extends StatelessWidget {
  final String label;

  const CustomCircularProgress({Key key, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        label != null
            ? Center(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Container(height: 3, width: 0),
        SizedBox(height: 10),
        CircularProgressIndicator(
          semanticsLabel: label ?? "",
          backgroundColor: Colors.black.withRed(50),
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
        ),
      ],
    );
  }
}
