import 'package:flutter/material.dart';
import 'package:ums_flutter/utils/constants.dart';

class ImagedHeader extends StatelessWidget {
  final String image;
  final String header1;
  final String header2;
  final String header3;

  const ImagedHeader(
      {Key key, this.image, @required this.header1, this.header2, this.header3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent])
                  .createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            //todo change image
            child: Image.asset(image ?? FALL_BACK_IMAGE,
                alignment: Alignment.topCenter,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.45,
                fit: BoxFit.fill),
          ),
          Positioned(
            bottom: 0,
            left: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  header1 ?? "",
                  style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: MediaQuery.of(context).size.width * 0.08,
                      fontWeight: FontWeight.w500,
                      color:
                          header2 != null ? Colors.white : Color(0xFFFD3664)),
                ),
                Row(
                  children: [
                    Text(header2 ?? "",
                        style: TextStyle(
                            fontFamily: 'Oswald',
                            fontSize: MediaQuery.of(context).size.width * 0.09,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFD3664))),
                    Text(
                      header3 != null && header2 != null ? ", " : "",
                      style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: MediaQuery.of(context).size.width * 0.09,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      header3 ?? "",
                      style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: MediaQuery.of(context).size.width * 0.09,
                          fontWeight: FontWeight.bold,
                          color: header2 != null
                              ? Colors.white
                              : Color(0xFFFD3664)),
                    ),
                  ],
                ),
              ],
            ), //move to a function
          ),
        ],
      ),
    );
  }
}
