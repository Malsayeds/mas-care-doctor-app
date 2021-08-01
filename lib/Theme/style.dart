import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData lightTheme = ThemeData(
  fontFamily: 'ProductSans',
  scaffoldBackgroundColor: scaffoldBackgroundColor,
  backgroundColor: backgroundColor,
  primaryColor: primaryColor,
  primaryColorLight: secondaryBackgroundColor,
  hintColor: textColor,
  disabledColor: disabledColor,
  dividerColor: secondaryBackgroundColor,

  ///app bar theme
  appBarTheme: AppBarTheme(color: transparentColor, elevation: 0),

  ///text theme
  textTheme: TextTheme(
      subtitle1: TextStyle(fontWeight: FontWeight.w400),
      subtitle2: TextStyle(),
      bodyText1: TextStyle(color: disabledColor),
      bodyText2: TextStyle(),
      headline5: TextStyle(fontWeight: FontWeight.bold)),
);

/// NAME         SIZE  WEIGHT  SPACING
/// headline1    96.0  light   -1.5
/// headline2    60.0  light   -0.5
/// headline3    48.0  regular  0.0
/// headline4    34.0  regular  0.25
/// headline5    24.0  regular  0.0
/// headline6    20.0  medium   0.15
/// subtitle1    16.0  regular  0.15
/// subtitle2    14.0  medium   0.1
/// body1        16.0  regular  0.5   (bodyText1)
/// body2        14.0  regular  0.25  (bodyText2)
/// button       14.0  medium   1.25
/// caption      12.0  regular  0.4
/// overline     10.0  regular  1.5
