import 'package:flutter/material.dart';
import 'package:ums_flutter/bloc/navigation_bloc.dart';


class MyAccountsScreen extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "My Accounts",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
      ),
    );
  }
}
