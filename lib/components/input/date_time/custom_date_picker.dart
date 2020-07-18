import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ums_flutter/components/buttons/buttons.dart';
import 'package:ums_flutter/components/components.dart';

class CustomDatePicker extends StatefulWidget {
  final String label;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final bool isBirthday;
  final bool initialYear;
  final Function(DateTime) onChange;

  const CustomDatePicker(
      {Key key,
      this.label,
      this.initialDate,
      this.firstDate,
      this.lastDate,
      @required this.onChange,
      this.isBirthday = false,
      this.initialYear = false})
      : super(key: key);

//  final Function(DateTime) onSelect;
//
//  const CupertinoDateTime({Key key,
//    @required this.initialDate,
//    @required this.firstDate,
//    @required this.lastDate,
//    @required this.onSelect})
//      : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime selectedDate;
  bool selected;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate ?? DateTime.now();
    selected = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 9),
      padding: EdgeInsets.symmetric(horizontal: 9),
      height: 55,
      decoration: BoxDecoration(
        color: Color(0xFF0D0D0D),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(4.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              widget.isBirthday
                  ? Icon(
                      Icons.cake,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                    ),
              SizedBox(width: 9),
              selected
                  ? Text(DateFormat("yyyy-MM-dd").format(selectedDate),
                      style: TextStyle(
                          color: Color(0xFFFD3664),
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0),
                    )
                  : Text(
                      widget.label ?? "Date Picker",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
            ],
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _selectDate(context),
            child: Container(
              child: Text(
                " Select",
                style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      lastDate: widget.lastDate ?? DateTime.now(),
      initialDate: widget.initialDate ?? DateTime.now(),
      firstDate: widget.lastDate ?? DateTime(1920, 06, 21),
      initialDatePickerMode:
          widget.initialYear ? DatePickerMode.year : DatePickerMode.day,
      context: context,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Color(0xFFFD3664),
              onPrimary: Colors.white,
              surface: Color(0xFF0D0D0D),
              onSurface: Colors.white70,
            ),
            dialogBackgroundColor: Color.fromRGBO(32, 32, 32, 1),
          ),
          child: child,
        );
      },
    );
    selected = true;
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onChange(picked);
    }
  }
}
