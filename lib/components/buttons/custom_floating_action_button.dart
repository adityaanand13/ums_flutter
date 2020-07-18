import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Function onPressed;
  final Icon icon;
  final String label;
  final Color color;

  const CustomFloatingActionButton({Key key, this.onPressed, @required this.icon, this.label, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new FloatingActionButton.extended(
      backgroundColor: color ?? Color(0xFFFD3664),
      //todo replace with icon data
      icon: icon,
      label: Text(label ?? "Press",
        style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
      ),
      onPressed: onPressed,
    );
  }
}
