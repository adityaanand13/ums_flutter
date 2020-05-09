import 'package:equatable/equatable.dart';

abstract class BacthState extends Equatable {
  const BacthState();
}

class InitialBacthState extends BacthState {
  @override
  List<Object> get props => [];
}
