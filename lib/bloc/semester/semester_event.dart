import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SemesterEvent extends Equatable {
  const SemesterEvent();
}

class SemesterActivate extends SemesterEvent {
  final int id;
  final int batchId;

  SemesterActivate({@required this.id, @required this.batchId});
  @override
  List<Object> get props => [id, batchId];

  @override
  String toString() => 'SemesterActivate{id: $id}';

}
