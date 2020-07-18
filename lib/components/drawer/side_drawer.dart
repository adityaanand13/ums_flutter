import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/bloc.dart';
import 'package:ums_flutter/services/services.dart';
import 'package:ums_flutter/utils/utils.dart';

import 'menu_item.dart';

class SideDrawer extends StatelessWidget {
  final AuthService authService;
  final UserService userService;

  SideDrawer({Key key, @required this.authService, @required this.userService})
      : assert(authService != null),
        assert(userService != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Drawer(
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserPresent) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black12.withOpacity(0.8),
                      Colors.black54.withOpacity(0.85),
                    ]),
              ),
              child: Column(
                children: <Widget>[
                  _userDetails(
                    username: state.userModel.username,
                    name:
                        '${state.userModel.firstName}  ${state.userModel.lastName},',
                    context: context,
                  ),
                  Divider(
                    height: SizeConfig.blockSizeVertical * 2.5,
                    thickness: 0.5,
                    color: Colors.blueAccent.withOpacity(0.3),
                    indent: 32,
                    endIndent: 32,
                  ),
                  _buildMenu(
                    userType: state.userModel.userType,
                    context: context,
                  ),
                  Divider(
                    height: SizeConfig.blockSizeVertical * 2.5,
                    thickness: 0.5,
                    color: Colors.blueAccent.withOpacity(0.3),
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
                      HapticFeedback.lightImpact();
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(AuthenticationEvent.LoggedOut);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/', (Route<dynamic> route) => false);
                    },
                  ),
                ],
              ),
            );
          } else if (state is UserLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserError) {
            return Center(child: Text('${state.error}'));
          } else if (state is UserAbsent) {
            BlocProvider.of<UserBloc>(context).add(GetUser());
            return CircularProgressIndicator();
          } else {
            return Center(
              child: Text("Internal App Error"),
            );
          }
        },
      ),
    );
  }

  Widget _userDetails({String username, String name, BuildContext context}) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/CollegesScreen', (route) => route.isFirst);
      },
      child: Column(
        children: <Widget>[
          SizedBox(
            height: SizeConfig.blockSizeVertical * 10,
          ),
          ListTile(
            title: Text(
              '$username',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                  fontWeight: FontWeight.w800),
            ),
            subtitle: Text(
              '$name',
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
        ],
      ),
    );
  }

  Widget _buildMenu({String userType, BuildContext context}) {
    if (userType == 'SUPER') {
      return _superAdminMenu(context);
    } else if (userType == 'ADMIN') {
      return Center(child: Text("Admin Menu"));
    } else if (userType == 'PRINCIPAL') {
      return Center(child: Text("Super Admin Menu"));
    } else if (userType == 'STUDENT') {
      return Center(child: Text("Super Admin Menu"));
    } else if (userType == 'INSTRUCTOR') {
      return Center(child: Text("Super Admin Menu"));
    } else {
      return Center(child: Text("Normal User $userType"));
    }
  }

  Widget _superAdminMenu(BuildContext context) {
    return Column(
      children: <Widget>[
        MenuItem(
          icon: Icons.home,
          title: "Home",
          onTap: () {
            HapticFeedback.lightImpact();
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/', (Route<dynamic> route) => false);
          },
        ),
        MenuItem(
          icon: Icons.school,
          title: "Colleges",
          onTap: () {
            HapticFeedback.lightImpact();
            Navigator.pushNamedAndRemoveUntil(context,
                '/CollegesScreen', (route) => route.isFirst);
          },
        ),
        MenuItem(
          icon: Icons.school,
          title: "Instructors",
          onTap: () {
            HapticFeedback.lightImpact();
            Navigator.pushNamedAndRemoveUntil(context,
                '/CollegesScreen', (route) => route.isFirst);
          },
        ),
      ],
    );
  }
}
