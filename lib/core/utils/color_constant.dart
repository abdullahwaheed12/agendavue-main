import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color bluebkg = fromHex('#1e2843');

  static Color black = fromHex('#000000');

  static Color darkModeBkg = fromHex('#121212');

  static Color darkModeButtons = fromHex('#414141');

  static Color darkModeFormField = fromHex('#3E3E3E');

  static Color darkModeUi = fromHex('#262626');

  static Color darkModeSimple = fromHex('#242424');

  static Color grey = fromHex('#9D9D9D');

  static Color deepPurple = fromHex('#5d26ca');

  static Color white = fromHex('#ffffff');

  //below are colors for all task/homework
  static Color homeWorkColorBkg = fromHex('#373737');
  static Color homeWorkColorTxt = fromHex('#CECCCC');
  static Color allTaskColorBkg = fromHex('#3A312A');
  static Color allTaskColorTxt = fromHex('#FFA656');

  //below are colors for subject icons
  static Color scienceColor = fromHex('#2D9CDB');
  static Color artColor = fromHex('#713CA7');
  static Color computerColor = fromHex('#FFF500');
  static Color languageColor = fromHex('#9F3342');
  static Color mathColor = fromHex('#FF7A00');
  static Color othersColor = fromHex('#421751');
  static Color sportColor = fromHex('#D70B26');
  static Color socialSciColor = fromHex('#27AE60');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
