import 'package:flutter/material.dart';
import '../core/app_export.dart';

class AppDecoration {
  static BoxDecoration get fillDeeppurple600 => BoxDecoration(
        color: ColorConstant.deepPurple,
      );
  static BoxDecoration get fillWhiteA700 => BoxDecoration(
        color: ColorConstant.white,
      );
  static BoxDecoration get fillBluegray900 => BoxDecoration(
        color: ColorConstant.grey,
      );
}

class BorderRadiusStyle {
  static BorderRadius roundedBorder16 = BorderRadius.circular(
    getHorizontalSize(
      16.00,
    ),
  );
}
