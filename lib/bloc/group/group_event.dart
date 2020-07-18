import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/models/models.dart';

@immutable
abstract class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object> get props => [];
}

class GroupCreated extends GroupEvent {
  final GroupResponse groupResponse;

  GroupCreated({@required this.groupResponse});

  @override
  String toString() => 'GroupCreated{groupResponse: $groupResponse}';

  @override
  List<Object> get props => [groupResponse];
}

class GroupFetch extends GroupEvent {
  final GroupResponse groupResponse;

  GroupFetch({@required this.groupResponse});

  @override
  String toString() => 'GroupFetch{groupResponse: $groupResponse}';

  @override
  List<Object> get props => [groupResponse];
}

class GroupAddStudent extends GroupEvent {
  final Student student;
  final int groupId;

  GroupAddStudent({
    @required this.student,
    this.groupId,
  });

  @override
  String toString() => 'GroupAddStudent{student: $student, groupId: $groupId}';

  @override
  List<Object> get props => [student];
}
