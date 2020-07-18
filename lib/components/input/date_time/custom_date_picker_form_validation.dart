import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ums_flutter/components/components.dart';

class CustomDatePickerFormValidation extends StatefulWidget {
  final String label;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final bool isBirthday;
  final bool initialYear;
  final FocusNode focusNode;
  final Function onFieldSubmit;
  final Function(DateTime) onChange;

  const CustomDatePickerFormValidation({
    Key key,
    this.label,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.isBirthday,
    this.initialYear,
    this.focusNode,
    this.onFieldSubmit,
    @required this.onChange,
  }) : super(key: key);

  @override
  _CustomDatePickerFormValidationState createState() =>
      _CustomDatePickerFormValidationState();
}

class _CustomDatePickerFormValidationState
    extends State<CustomDatePickerFormValidation> {
  TextEditingController _controller;
  DateTime selectedDate;
  bool intro;

  @override
  void initState() {
    intro = true;
    _controller = TextEditingController();
    selectedDate = widget.initialDate ?? DateTime.now();
    widget.focusNode.addListener(() {
      if (widget.focusNode.hasFocus && intro) {
        _selectDate();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(),
      child: IgnorePointer(
        child: TextFormFieldValidation(
          label: widget.label ?? "Date Picker",
          prefixIcon: widget.isBirthday ? Icons.cake : Icons.calendar_today,
          suffixIcon: IconButton(
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.red,
            ),
            onPressed: null,
          ),
          validator: (String val) {
            if (val.length > 1)
              return null;
            else
              return "This Field is Required";
          },
          focusNode: widget.focusNode,
          preventKeyboard: true,
          controller: _controller,
          onValueChanged: (val) {},
        ),
      ),
    );
  }

  Future<Null> _selectDate() async {
    FocusScope.of(context).requestFocus(widget.focusNode);
    final DateTime picked = await showDatePicker(
      helpText: "Select ${widget.label ?? "Date Picker"}",
      fieldHintText: "mm/DD/YYYY",
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
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      String _newValue = DateFormat("dd-MM-yyyy").format(selectedDate);
      _controller.value = TextEditingValue(
        text: _newValue,
        selection: TextSelection.fromPosition(
          TextPosition(offset: _newValue.length),
        ),
      );
      widget.onChange(picked);
      widget.onFieldSubmit();
    }
    setState(() {
      intro = false;
    });
  }
}
