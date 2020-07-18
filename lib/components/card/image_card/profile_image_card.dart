import 'package:flutter/material.dart';
import 'package:ums_flutter/utils/constants.dart';

class ProfileImageCard extends StatelessWidget {
  final Function onTap;
  final String image;
  final String header;
  final String detail1;
  final String detail2Label;
  final String detail2;

  const ProfileImageCard({
    Key key,
    this.onTap,
    this.image,
    this.header,
    @required this.detail1,
    this.detail2Label,
    this.detail2,
  })  : assert(detail1 != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage(
                image != null ? image : GIRL_PROFILE_FALL_BACK_IMAGE),
            fit: BoxFit.cover,
          ),
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                header != null
                    ? Container(
                        height: 40,
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(36, 36, 36, 0.7),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                topLeft: Radius.circular(8))),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            "$header",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFFD3664),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: 0,
                        width: 0,
                      ),
                Divider(
                  height: 0,
                  thickness: 0.5,
                  color: Colors.white54,
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.02),
                      Colors.black,
                    ],
                    stops: [
                      0.0,
                      1.0
                    ]),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$detail1",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1),
                  ),
                  Row(
                    children: [
                      detail2Label != null
                          ? Text(
                              "$detail2Label: ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white54,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          : Container(
                              height: 0,
                              width: 0,
                            ),
                      detail2 != null
                          ? Text(
                              "$detail2",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          : Container(
                              height: 0,
                              width: 0,
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
