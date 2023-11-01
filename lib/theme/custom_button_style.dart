import 'dart:ui';
import 'package:hotel_booking/utils/app_export.dart';
import 'package:flutter/material.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Gradient button style
  static BoxDecoration get gradientCyanToBlueGrayDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(getHorizontalSize(12.00)),
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [
            // appTheme.cyan300,
            appTheme.blueGray600,
          ],
        ),
      );

  // Outline button style
  static ButtonStyle get outline => OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(getHorizontalSize(12.00)),
        ),
      );
  // text button style
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      );
}
