import 'package:flutter/material.dart';

class Palette {
  ///////////// primary color////////////
  /// 351334
////////////////////////////////////
  ///
//////////////// secondary color/////////
  ///9A1921
////////////////////////////////////
  ///
/////////////////app primary color////////
  ///C94854
////////////////////////////////////
  ///
///////////////app secondary color//////////
  ///A067A3
////////////////////////////////////
  ///
////////////////////// white color///////////////
  ///FFFFFF
/////////////////////////////////////////////////
  ///
////////////////////black color//////////////////
  ///000000
/////////////////////////////////////////////////
  ///
///////////////////////grey color////////////////
  ///757575
/////////////////////////////////////////////////
  ///
/////////////////////////grey white color//////////
  ///E6E6E6
///////////////////////////////////////////////////
  //////////////////////colors//////////////////////
  ///
  ///
  static const Color primaryColor = Color(0xFF687daf);
  static const Color scafoldColor = Color.fromARGB(255, 236, 238, 241);
  static const Color separatorColor = Color.fromARGB(255, 225, 225, 225);
  static const Color textColor = Color(0xFF3d3d3d);
  static const Color blueColor = Color(0xFF526799);
  static const Color redColor = Color(0xFFF37B67);
  static const Color appBlack = Color(0xFF3c4c4c);
  static const Color secondaryColor = Color(0xFFe4662d);
  static const Color appRed = Color(0xFFb41434);
  /////////
  static const Color appPrimaryColor = Color(0xFFf5a535);
  static const Color appSecondaryColor = Color(0xFFf2c17e);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color greyColor = Color(0xFF757575);
  static const Color greyWhiteColor = Color(0xFFE6E6E6);
  static const Color greySecondaryColor = Color(0xFF696969);

  /////////////////////////////////////////////////////
  ///
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF9A1921, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0x02e7b641), //10%
      100: Color(0x02e7bc3a), //20%
      200: Color(0x02e7b332), //30%
      300: Color(0x02e7b92b), //40%
      400: Color(0x02e7b024), //50%
      500: Color(0x02e7b61d), //60%
      600: Color(0x02e7bc16), //70%
      700: Color(0x02e7b30e), //80%
      800: Color(0x02e7b907), //90%
      900: Color(0x02e7b000), //100%
    },
  );
}
