import 'package:flutter/material.dart';

class AppColors {
  static const secondary = Color(0xff00670A);
  static const primary = Color(0xffFF6C2E);
  static const ancient = Color(0xff518946);

  static const textBlack = Color(0xff171C15);
  static const textGray = Color(0xFF808080);

  static const error = Color(0xffFF4B3D);
  static const black = Color(0xff121212);
  static const grayBG = Color(0xffECECEC);
  static const whiteBG = Color(0xfff8f8f8);

  static final ancientSwatch = MaterialColor(
    ancient.value,
    const {
      50: Color(0xffEBFFEA),
      100: Color(0xffC9E5C4), //10%
      200: Color(0xffAFD89E), //20%
      300: Color(0xff95BE8D), //30%
      400: Color(0xff639562), //40%
    },
  );

  static final greenSwatch = MaterialColor(
    primary.value,
    const {
      50: Color(0xff90C788),
      100: Color(0xff4EB558),
      200: Color(0xff049913),
      300: Color(0xff0A8516),
    },
  );

  static final orangeSwatch = MaterialColor(
    secondary.value,
    const {
      50: Color(0xffFFF3EB),
      100: Color(0xffFFE3B8),
      200: Color(0xffFFC700),
      300: Color(0xffFFA53A),
      400: Color(0xffC4501B),
    },
  );

  static const greenGradient = LinearGradient(
    colors: [
      Color(0xff90C788),
      Color(0xff049913),
    ],
    stops: [0.56, 1.0],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static const lightGreenGradient = LinearGradient(
    colors: [
      Color(0xffC9E5C4),
      Color(0xffEBFFEA),
    ],
  );

  static const orangeGradient = LinearGradient(
    colors: [
      Color(0xffFFA53A),
      Color(0xffFFE3B8),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
