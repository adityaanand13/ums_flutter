import 'package:flutter_bloc/flutter_bloc.dart';

enum AnimationEvent{
  DrawerOpened,
  DrawerClosed,
}


class DrawerAnimationBloc extends Bloc<AnimationEvent, bool>{
  @override
  // TODO: implement initialState
  bool get initialState => false;

  @override
  Stream<bool> mapEventToState(AnimationEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }

}