import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/navigation_bloc.dart';
import 'package:ums_flutter/utils/sizeConfig.dart';

import 'menu_item.dart';

class SuperMenu extends StatelessWidget {
  final Function onIconPressed;

  SuperMenu({Key key, this.onIconPressed}):assert(onIconPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MenuItem(
          icon: Icons.home,
          title: "Home",
          onTap: () {
            onIconPressed();
            BlocProvider.of<NavigationBloc>(context)
                .add(NavigationEvents.HomePageClickedEvent);
          },
        ),
        MenuItem(
          icon: Icons.person,
          title: "My Account",
          onTap: () {
            onIconPressed();
            BlocProvider.of<NavigationBloc>(context)
                .add(NavigationEvents.MyAccountClickedEvent);
          },
        ),
        MenuItem(
          icon: Icons.shopping_basket,
          title: "My Orders",
          onTap: () {
            onIconPressed();
            BlocProvider.of<NavigationBloc>(context)
                .add(NavigationEvents.MyOrdersClickedEvent);
          },
        ),
        MenuItem(
          icon: Icons.card_giftcard,
          title: "Wishlist",
        ),
      ],
    );
  }
}
