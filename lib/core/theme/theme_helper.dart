import 'package:flutter/material.dart';

LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.

// ignore_for_file: must_be_immutable
class ThemeHelper {
  // The current app theme
  var _appTheme = "lightCode";

  // A map of custom color themes supported by the app
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

  // A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
    );
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light();
}

class LightCodeColors {
  // App Colors
  Color get black => Color(0xFF1E1E1E);
  Color get white => Color(0xFFFFFFFF);

  // Additional Colors
  Color get whiteCustom => Colors.white;
  Color get blackCustom => Colors.black;
  Color get transparentCustom => Colors.transparent;
  Color get greyCustom => Colors.grey;
  Color get colorFF0EA5 => Color(0xFF0EA5E9);
  Color get colorFF0369 => Color(0xFF0369A1);
  Color get colorFFE0F2 => Color(0xFFE0F2FE);

  // Color Shades - Each shade has its own dedicated constant
  Color get grey200 => Colors.grey.shade200;
  Color get grey100 => Colors.grey.shade100;

  // New Colors
  Color get colorFFF3F4 => Color(0xFFF3F4F6);
  Color get colorFFF0F9 => Color(0xFFF0F9FF);
  Color get colorFF1F29 => Color(0xFF1F2937);
  Color get colorFF6B72 => Color(0xFF6B7280);
  Color get colorFF2563 => Color(0xFF2563EB);
  Color get colorFFE5E7 => Color(0xFFE5E7EB);
  Color get colorFF3741 => Color(0xFF374151);
  Color get colorFF9CA3 => Color(0xFF9CA3AF);
  Color get colorFFF9FA => Color(0xFFF9FAFB);
  Color get colorFFD1D5 => Color(0xFFD1D5DB);
  Color get colorFF3B82 => Color(0xFF3B82F6);
}
