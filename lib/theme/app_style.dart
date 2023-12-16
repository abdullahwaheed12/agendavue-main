import 'package:flutter/material.dart';
import '../core/app_export.dart';

class AppStyle {
  static TextStyle onBoardingSubTitle = TextStyle(
    color: ColorConstant.white,
    fontSize: getFontSize(
      15,
    ),
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
  );

  static TextStyle onBoardingTitle = TextStyle(
    color: ColorConstant.white,
    fontSize: getFontSize(
      50,
    ),
    fontFamily: 'Roboto Slab',
    fontWeight: FontWeight.w700,
  );

  static TextStyle poppinsBold = TextStyle(
    color: ColorConstant.white,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
  );
  static TextStyle poppinsRegural = TextStyle(
    color: ColorConstant.white,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.normal,
  );
}
