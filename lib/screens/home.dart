import 'package:flutter/material.dart';
import 'package:ums_flutter/bloc/navigation_bloc.dart';

class HomeScreen extends StatelessWidget with NavigationStates {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "HomePage",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}
