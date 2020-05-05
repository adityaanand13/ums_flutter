import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef Null ValueChangeCallback(String value);

class TextFormFieldValidation extends StatefulWidget {
  final ValueChangeCallback onValueChanged;
  final String hint;
  final TextEditingController controller;
  final Function validator;
  final Color containerColor;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final FormFieldSetter<String> onSaved;
  final bool enabled;
  final String initialValue;
  final bool obscureText;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final bool autofocus;
  final bool isLastEntry;
  final Function onFormSubmit;
  final List<TextInputFormatter> textInputFormatter;

  TextFormFieldValidation({
    Key key,
    @required this.hint,
    this.controller,
    @required this.onValueChanged,
    this.enabled = true,
    this.onSaved,
    this.keyboardType,
    this.textCapitalization,
    this.validator,
    this.containerColor,
    this.initialValue,
    this.obscureText,
    this.focusNode,
    this.nextFocusNode,
    this.autofocus = false,
    this.isLastEntry = false,
    this.onFormSubmit,
    this.textInputFormatter,
  }) : super(key: key);

  @override
  _TextFormFieldValidationState createState() =>
      _TextFormFieldValidationState();
}

class _TextFormFieldValidationState extends State<TextFormFieldValidation> {
  TextEditingController valueController;

  @override
  void initState() {
    super.initState();
    valueController = widget.controller ??
        TextEditingController.fromValue(
            TextEditingValue(text: widget.initialValue ?? ""));
    valueController.addListener(() {
      widget.onValueChanged(valueController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        maxLines: null,
        autofocus: widget.autofocus,
        enabled: widget.enabled ?? true,
        onSaved: widget.onSaved ?? (String value) {},
        keyboardType: widget.keyboardType ?? TextInputType.text,
        textCapitalization:
            widget.textCapitalization ?? TextCapitalization.none,
        obscureText: widget.obscureText ?? false,
        controller: valueController,
        textInputAction: !widget.isLastEntry ? TextInputAction.next : TextInputAction.send,
        onFieldSubmitted: !widget.isLastEntry
            ? (term) => _fieldFocusChange(context, widget.focusNode, widget.nextFocusNode)
            : (term) {
          widget.focusNode.unfocus();
          widget.onFormSubmit(context);
        },
        inputFormatters: widget.textInputFormatter ?? <TextInputFormatter>[],
        validator: widget.validator ??
            (String value) {
              if (value.isEmpty) {
                return 'This field is required';
              }
              if (value.length < 2) {
                return 'Characters must be a min of 2';
              }
              return null;
            },
        style: TextStyle(color: Color(0xFFFD3664)),
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFF0D0D0D),
          labelText: widget.hint,
          labelStyle: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(.5))),
          errorBorder: OutlineInputBorder(borderSide: BorderSide(color:  Colors.redAccent.withOpacity(.5))),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:  Colors.white.withOpacity(.8))),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(.5))),
        ),
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
