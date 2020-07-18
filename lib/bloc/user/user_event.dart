import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  UserEvent([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class GetUser extends UserEvent {
  @override
  String toString() => 'GetUser';
}

class FetchUser extends UserEvent {
  @override
  String toString() => 'FetchUser';
}

class UpdateUser extends UserEvent {
  @override
  String toString() => 'UpdateUser';
}

class DeleteUser extends UserEvent {
  @override
  String toString() => 'DeleteUser';
}

