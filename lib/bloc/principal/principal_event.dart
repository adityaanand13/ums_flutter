import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class PrincipalEvent extends Equatable {
  const PrincipalEvent();

  @override
  List<Object> get props => [];
}

class PrincipalSearchQuery extends PrincipalEvent {
  final String key;

  const PrincipalSearchQuery({@required this.key});

  @override
  List<Object> get props => [key];

  @override
  String toString() => 'PrincipalSearchQuery{key: $key}';
}

class AssignNewPrincipal extends PrincipalEvent {
  final int instructorId;
  final int collegeId;

  AssignNewPrincipal({
    @required this.instructorId,
    @required this.collegeId,
  });

  @override
  List<Object> get props => [instructorId, collegeId];

  @override
  String toString() =>
      'NewPrincipal{instructorId: $instructorId, collegeId: $collegeId}';
}
