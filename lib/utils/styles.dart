import 'package:flutter/material.dart';
import 'package:ums_flutter/utils/sizeConfig.dart';

kTitleStyle(BuildContext context) {
  SizeConfig().init(context);
  return TextStyle(
    color: Colors.white,
    fontFamily: 'CM Sans Serif',
    fontSize: SizeConfig.blockSizeHorizontal * 10,
    height: SizeConfig.blockSizeVertical * 0.2,
  );
}

 kSubtitleStyle(BuildContext context) {
   SizeConfig().init(context);
   return TextStyle(
     color: Colors.white,
     fontSize: SizeConfig.blockSizeHorizontal * 6,
     height: SizeConfig.blockSizeVertical * .2,
   );
 }