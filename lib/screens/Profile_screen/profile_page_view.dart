import 'package:flutter/material.dart';
import 'package:ums_flutter/models/user_model.dart';
import 'package:ums_flutter/utils/sizeConfig.dart';

class ProfilePageView extends StatefulWidget {
  final PageController _pageController = PageController(initialPage: 0);
  final double opacity = 0.2;
  UserModel userModel;

  ProfilePageView({Key key, @required this.userModel})
      : assert(userModel != null),
        super(key: key);

  @override
  _ProfilePageViewState createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _slideAnimation;
  Animation _fadeAnimation;
  int currentIndex = 0;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _slideAnimation = TweenSequence([
      TweenSequenceItem<Offset>(
          weight: 10, tween: Tween(begin: Offset(0, 0), end: Offset(0, 1))),
      TweenSequenceItem<Offset>(
          weight: 90, tween: Tween(begin: Offset(0, 1), end: Offset(0, 0)))
    ]).animate(_controller);
    _fadeAnimation = TweenSequence([
      TweenSequenceItem<double>(weight: 10, tween: Tween(begin: 1, end: 0)),
      TweenSequenceItem<double>(weight: 90, tween: Tween(begin: 0, end: 1))
    ]).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: <Widget>[
      Image.asset(
        "images/profile3.jpg",
        fit: BoxFit.cover,
      ),
      DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.black.withOpacity(1),
            Colors.black.withOpacity(0.6),
            Colors.black.withOpacity(0.4),
            Colors.white.withOpacity(0),
          ], stops: [
            0.1,
            0.2,
            0.25,
            1
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        ),
      ),
      Positioned(
        bottom: 105,
        left: 20,
        right: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  widget.userModel.username,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.blockSizeHorizontal * 6.5,
                  ),
                ),
                Text(
                  widget.userModel.userType == "STUDENT" ? "college" : widget.userModel.userType,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                    fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                  ),
                ),
              ],
            )
          ],
        ),
      )
    ]);
  }
}
