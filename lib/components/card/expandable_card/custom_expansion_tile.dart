import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomExpansionTile extends StatefulWidget {
  final String label;
  final List<Widget> widgetList;
  final int crossAxisCount;
  final double axisSpacing;

  const CustomExpansionTile(
      {Key key,
      @required this.label,
      @required this.widgetList,
      this.crossAxisCount = 2,
      this.axisSpacing = 9.0})
      : assert(label != null),
        assert(widgetList != null),
        super(key: key);

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _visibility;

  @override
  void initState() {
    super.initState();
    _visibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: widget.axisSpacing / 2),
      padding: EdgeInsets.all(widget.axisSpacing),
      decoration: BoxDecoration(
        color: Color(0xFF0D0D0D),
        border: Border.all(
            color: _visibility ? Colors.white38 : Colors.white24, width: 1.5),
        borderRadius: BorderRadius.circular(widget.axisSpacing),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              HapticFeedback.lightImpact();
              setState(() {
                _visibility = !_visibility;
              });
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(widget.axisSpacing),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.label}",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w100,
                        color: Colors.white),
                  ),
                  Icon(
                    _visibility
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          _visibility
              ? GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: widget.crossAxisCount,
                  mainAxisSpacing: widget.axisSpacing,
                  crossAxisSpacing: widget.axisSpacing,
                  primary: false,
                  children: widget.widgetList,
                )
              : Container(
                  height: 0,
                  width: 0,
                ),
        ],
      ),
    );
  }
}
