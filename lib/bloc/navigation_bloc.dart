import 'package:bloc/bloc.dart';
import 'package:ums_flutter/screens/home.dart';
import 'package:ums_flutter/screens/my_accounts_screen.dart';
import 'package:ums_flutter/screens/my_orders_screen.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  MyAccountClickedEvent,
  MyOrdersClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => MyAccountsScreen();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield HomeScreen();
        break;
      case NavigationEvents.MyAccountClickedEvent:
        yield MyAccountsScreen();
        break;
      case NavigationEvents.MyOrdersClickedEvent:
        yield MyOrdersScreen();
        break;
    }
  }
}
