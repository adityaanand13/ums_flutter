import 'package:flutter/material.dart';

class SingleItemCard extends StatelessWidget {
  final onTap;
  final String label;

  const SingleItemCard({Key key, this.onTap, @required this.label}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF0D0D0D),
          border: Border.all(
            color: Colors.white24,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.all(10),
        child: Text( label ?? "!!",
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.white),
        ),
      ),
    );
  }
}
