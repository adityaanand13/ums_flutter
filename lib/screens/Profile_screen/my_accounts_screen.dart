import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/navigation_bloc.dart';
import 'package:ums_flutter/bloc/user_bloc.dart';
import 'package:ums_flutter/event_state/user/user_event.dart';
import 'package:ums_flutter/event_state/user/user_state.dart';
import 'package:ums_flutter/services/user_service.dart';
import 'package:ums_flutter/utils/sizeConfig.dart';

import 'profile_page_view.dart';

class MyAccountsScreen extends StatefulWidget with NavigationStates {
  //todo check for unused variable
  final UserService userService;

  const MyAccountsScreen({Key key, this.userService})
      : assert(userService != null),
        super(key: key);
  @override
  _MyAccountsScreenState createState() => _MyAccountsScreenState();
}

class _MyAccountsScreenState extends State<MyAccountsScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _heightFactorAnimation;

  double expandedHeightFactor = 0.5;
  double collapsedHeightFactor = 0.90;
  bool isAnimationComplete = false;
  double screenHeight = 0;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _heightFactorAnimation =
        Tween<double>(begin: collapsedHeightFactor, end: expandedHeightFactor)
            .animate(_controller);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isAnimationComplete = true;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  onBottomPartTap() {
    setState(() {
      if (isAnimationComplete) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      isAnimationComplete = !isAnimationComplete;
    });
  }

  _handelVerticalUpdate(DragUpdateDetails updateDetails) {
    double fractionDragged = updateDetails.primaryDelta / screenHeight;
    _controller.value = _controller.value - 5 * fractionDragged;
  }

  _handleVerticalEnd(DragEndDetails endDetails) {
    if (_controller.value >= 0.5) {
      _controller.fling(velocity: 1);
    } else {
      _controller.fling(velocity: -1);
    }
  }

  getWidget() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserPresent) {
          return Stack(fit: StackFit.expand, children: <Widget>[
            FractionallySizedBox(
              alignment: Alignment.topCenter,
              heightFactor: _heightFactorAnimation.value,
              child: ProfilePageView(userModel: state.userModel,),
            ),
            GestureDetector(
              onVerticalDragUpdate: _handelVerticalUpdate,
              onVerticalDragEnd: _handleVerticalEnd,
              onTap: () {
                onBottomPartTap();
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  FractionallySizedBox(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 1.1 - _heightFactorAnimation.value,
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.only(top: 35, left: 10, right: 10),
                        child: Text(
                          '${state.userModel.firstName} ${state.userModel.lastName}',
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w700,
                              fontSize: SizeConfig.blockSizeHorizontal * 5.1),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1.0, 0.0),
                              blurRadius: 10.0)
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(55.0),
                            topRight: Radius.circular(55.0)),
                      ),
                    ),
                  ),
                  FractionallySizedBox(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 0.93 - _heightFactorAnimation.value,
                    child: new Material(
                      elevation: 4.0,
                      shadowColor: Colors.black,
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(top: 80, left: 55),
                          child: new Text(
                            "Father's Name:\n\n "
                            "Course:\n\n "
                            "Batch:\n\n "
                            "Date of Birth:\n\n "
                            "Date of Issue:\n\n "
                            "F/Contact No. :\n\n"
                            "Address:\n\n ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0),
                          ),
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Colors.blue, Colors.black]),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                offset: Offset(1.0, 0.0),
                                blurRadius: 10)
                          ],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(65.0),
                              topRight: Radius.circular(65.0)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ]);
        }
        else if (state is UserAbsent) {
          BlocProvider.of<UserBloc>(context).add(GetUser());
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: AnimatedBuilder(
      animation: _controller,
      builder: (context, widget) {
        return getWidget();
      },
    ));
  }
}
