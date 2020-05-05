import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AddPrincipalEvent extends Equatable {
  const AddPrincipalEvent();
}

class AddButtonPressed extends AddPrincipalEvent {
  final String username;
  final int collegeId;

  const AddButtonPressed({
    @required this.username,
    @required this.collegeId,
  });

  @override
  // TODO: implement props
  List<Object> get props => [username, collegeId];

  String toString() =>
      'New Principal { username: $username, collegeId: $collegeId}';
}
