import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ums_flutter/components/buttons/flat_button_custom.dart';

enum Action {
  okay,
  primary,
  error,
  warning,
}

extension ParseToString on Action {
  String toShortString() => this.toString().split('.').last;
}

class BottomSheetInfo extends StatefulWidget {
  final BuildContext buildContext;
  final String heading;
  final String information;
  final Action action;
  final Function onAction;
  final String actionLabel;
  final Icon actionIcon;

  const BottomSheetInfo({
    Key key,
    @required this.buildContext,
    @required this.heading,
    this.information,
    this.action = Action.primary,
    this.onAction,
    this.actionLabel,
    this.actionIcon,
  })  : assert(buildContext != null),
        super(key: key);

  @override
  _BottomSheetInfoState createState() => _BottomSheetInfoState();
}

class _BottomSheetInfoState extends State<BottomSheetInfo> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height*0.4,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              color: Color.fromRGBO(32, 32, 32, 1),
            ),
            height: 50,
            child: Center(
              child: Text(
                widget.heading ?? widget.action.toString().toUpperCase(),
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Color.fromRGBO(16, 16, 16, 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.information != null
                    ? Text(
                        widget.information,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      )
                    : Container(
                        height: 0,
                        width: 0,
                      ),
                Center(
                  child: FlatButtonCustom(
                    title: widget.actionLabel ?? "Okay",
                    iconData: Icons.done,
                    color: Colors.green,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      widget.onAction != null
                          ? widget.onAction()
                          : Navigator.pop(widget.buildContext);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

//child: Column(
//mainAxisSize: MainAxisSize.max,
//mainAxisAlignment: MainAxisAlignment.center,
//children: [
//Container(
//height: 125,
//decoration: BoxDecoration(
//color: Colors.white,
//borderRadius: BorderRadius.all(Radius.circular(15)),
//boxShadow: [
//BoxShadow(
//blurRadius: 10, color: Colors.grey[300], spreadRadius: 5)
//]),
//child: Column(children: []),
//),
//Container(
//height: 50,
//alignment: Alignment.center,
//padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//decoration: BoxDecoration(
//color: Colors.grey[300],
//borderRadius: BorderRadius.circular(10),
//),
//child: TextField(
//decoration: InputDecoration.collapsed(
//hintText: 'Enter your reference number',
//),
//),
//)
//],
//),
