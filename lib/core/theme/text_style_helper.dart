import 'package:dr_dental/core/app_export.dart';
import 'package:dr_dental/core/theme/theme_helper.dart';
import 'package:flutter/material.dart';

/// A helper class for managing text styles in the application
class TextStyleHelper {
  static TextStyleHelper? _instance;

  TextStyleHelper._();

  static TextStyleHelper get instance {
    _instance ??= TextStyleHelper._();
    return _instance!;
  }

  // Headline Styles
  // Medium-large text styles for section headers

  TextStyle get headline30Bold => TextStyle(
        fontSize: 30.fSize,
        fontWeight: FontWeight.bold,
        color: appTheme.whiteCustom,
      );

  // Title Styles
  // Medium text styles for titles and subtitles

  TextStyle get title20RegularRoboto => TextStyle(
        fontSize: 20.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      );

  TextStyle get title24BoldPoppins => TextStyle(
        fontSize: 24.fSize,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins',
      );

  TextStyle get title16MediumPoppins => TextStyle(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      );

  // Body Styles
  // Standard text styles for body content

  TextStyle get body14 => TextStyle(
        fontSize: 14.fSize,
        color: appTheme.colorFFE0F2,
      );

  TextStyle get body14Poppins => TextStyle(
        fontSize: 14.fSize,
        fontFamily: 'Poppins',
      );

  TextStyle get body14MediumPoppins => TextStyle(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      );

  TextStyle get bodyPoppins => TextStyle(
        fontFamily: 'Poppins',
      );
}
