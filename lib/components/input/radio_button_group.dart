import 'package:flutter/material.dart';

class RadioData {
  final int value;
  final String label;

  RadioData({@required this.value, @required this.label});
}

class RadioButtonGroup extends StatefulWidget {
  final List<RadioData> radioDate;

  const RadioButtonGroup({Key key, @required this.radioDate}) : super(key: key);
  @override
  _RadioButtonGroupState createState() => _RadioButtonGroupState();
}

class _RadioButtonGroupState extends State<RadioButtonGroup> {


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
