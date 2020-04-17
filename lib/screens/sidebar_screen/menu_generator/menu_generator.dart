import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/navigation/navigation_bloc.dart';
import 'package:ums_flutter/bloc/user_bloc.dart';
import 'package:ums_flutter/event_state/user/user_event.dart';
import 'package:ums_flutter/event_state/user/user_state.dart';
import 'package:ums_flutter/services/user_service.dart';
import 'package:ums_flutter/utils/sizeConfig.dart';

import 'user_based_menu/menu_item.dart';
import 'user_based_menu/super_admin_menu.dart';

class MenuGenerator extends StatelessWidget {
  final Function onIconPressed;
  final UserService userService;
  MenuGenerator({
    Key key,
    @required this.userService,
    @required this.onIconPressed,
  })  : assert(userService != null),
        assert(onIconPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserPresent) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: SizeConfig.blockSizeVertical * 10,
            ),
            ListTile(
              title: Text(
                '${state.userModel.username}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                    fontWeight: FontWeight.w800),
              ),
              subtitle: Text(
                '${state.userModel.firstName} ${state.userModel.lastName}',
                style: TextStyle(
                  color: Color(0xFF1BB5FD),
                  fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                ),
              ),
              leading: CircleAvatar(
                child: Icon(
                  Icons.perm_identity,
                  color: Colors.white,
                ),
                radius: 40,
              ),
            ),
            Divider(
              height: SizeConfig.blockSizeVertical * 2.5,
              thickness: 0.5,
              color: Colors.white.withOpacity(0.3),
              indent: 32,
              endIndent: 32,
            ),
            _buildMenu(state.userModel.userType),
            Divider(
              height: SizeConfig.blockSizeVertical * 2.5,
              thickness: 0.5,
              color: Colors.white.withOpacity(0.3),
              indent: 32,
              endIndent: 32,
            ),
            MenuItem(
              icon: Icons.settings,
              title: "Settings",
            ),
            MenuItem(
              icon: Icons.exit_to_app,
              title: "Logout",
              onTap: () {
                onIconPressed();
                BlocProvider.of<NavigationBloc>(context)
                    .add(NavigationEvents.LogoutClickedEvent);
              },
            ),
          ],
        );
      } 
      else if (state is UserAbsent) {
        BlocProvider.of<UserBloc>(context).add(GetUser());
        return Center(
          child: CircularProgressIndicator(),
        );
      } 
      else if (state is UserLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } 
      else if (state is UserError) {
        return Center(child: Text('${state.error}'));
      }
      //todo refactor default case
      else {
        print("Null part");
        return Column(
          children: <Widget>[
            SizedBox(
              height: SizeConfig.blockSizeVertical * 10,
            ),
            ListTile(
              title: Text(
                "User Name",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                    fontWeight: FontWeight.w800),
              ),
              subtitle: Text(
                "Full Name",
                style: TextStyle(
                  color: Color(0xFF1BB5FD),
                  fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                ),
              ),
              leading: CircleAvatar(
                child: Icon(
                  Icons.perm_identity,
                  color: Colors.white,
                ),
                radius: 40,
              ),
            ),
            Divider(
              height: SizeConfig.blockSizeVertical * 2.5,
              thickness: 0.5,
              color: Colors.white.withOpacity(0.3),
              indent: 32,
              endIndent: 32,
            ),
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
            Divider(
              height: SizeConfig.blockSizeVertical * 2.5,
              thickness: 0.5,
              color: Colors.white.withOpacity(0.3),
              indent: 32,
              endIndent: 32,
            ),
            MenuItem(
              icon: Icons.settings,
              title: "Settings",
            ),
            MenuItem(
              icon: Icons.exit_to_app,
              title: "Logout",
              onTap: () {
                onIconPressed();
                BlocProvider.of<NavigationBloc>(context)
                    .add(NavigationEvents.LogoutClickedEvent);
              },
            ),
          ],
        );
      }
    });
  }

  Widget _buildMenu(String userType) {
    if (userType == 'SUPER')
      return SuperMenu(onIconPressed: onIconPressed);
    else
      return Column(
        children: [],
      );
  }
}
