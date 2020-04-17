import 'package:flutter/material.dart';
import 'package:ums_flutter/bloc/navigation/navigation_bloc.dart';



class MyOrdersScreen extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "My Orders",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
      ),
    );
  }
}
