import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Item {
  const Item({@required this.label, this.prefixIcon, @required this.value});

  final String label;
  final IconData prefixIcon;
  final dynamic value;
}

class DropDownFieldValidation extends StatefulWidget {
  final List<Item> items;
  final String hint;
  final String label;
  final IconData prefixIcon;
  final Function onFieldSubmit;
  final Function validator;
  final FocusNode focusNode;
  final Function(dynamic) onValueChanged;

  const DropDownFieldValidation({
    Key key,
    @required this.items,
    this.hint,
    @required this.onValueChanged,
    this.prefixIcon,
    this.onFieldSubmit,
    this.validator,
    @required this.label,
    this.focusNode,
  }) : super(key: key);

  @override
  _DropDownFieldValidationState createState() =>
      _DropDownFieldValidationState();
}

class _DropDownFieldValidationState extends State<DropDownFieldValidation> {
  int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = -1;
    super.initState();
  }

  _onChange(int index) {
    if (index != _selectedIndex) {
      widget.onValueChanged(widget.items[index].value);
      setState(() {
        _selectedIndex = index;
      });
      widget.focusNode.unfocus();
      widget.onFieldSubmit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 9),
      child: DropdownButtonFormField(
        focusNode: widget.focusNode,
        onChanged: _onChange,
        items: List.generate(
          widget.items.length,
          (i) => DropdownMenuItem(
            value: i,
            child: Row(
              mainAxisAlignment: widget.items[i].prefixIcon != null
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.start,
              children: [
                widget.items[i].prefixIcon != null
                    ? Icon(widget.items[i].prefixIcon, color: Colors.white)
                    : Container(),
                Text(
                  widget.items[i].label,
                  style: TextStyle(
                      fontSize: 16,
                      color: i == _selectedIndex
                          ? Color(0xFFFD3664)
                          : Colors.white,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
        dropdownColor: Color(0xFF181818),
        elevation: 16,
        iconEnabledColor: Colors.redAccent,
        validator: (int arg) {
          if (arg == -1)
            return 'Please Select an Appropriate option.';
          else
            return null;
        },
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon, color: Colors.white)
              : null,
          filled: true,
          fillColor: Color(0xFF0D0D0D),
          labelText: widget.label,
          labelStyle: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withOpacity(.5))),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent.withOpacity(.5))),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.white.withOpacity(.8), width: 3)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withOpacity(.5))),
        ),
      ),
    );
  }
}
