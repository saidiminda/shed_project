import 'package:flutter/material.dart';
import '../utils/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLargeBlack900 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.black900,
      );
  static get bodyLargeBluegray700 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.blueGray700,
      );
  static get bodyLargeCyan300 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.cyan300,
      );
  static get bodyLargePrimary => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get bodyMedium15 => theme.textTheme.bodyMedium!.copyWith(
        fontSize: getFontSize(
          15,
        ),
      );
  static get bodyMediumBluegray600 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray600,
      );
  static get bodyMediumGray400 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray400,
        fontSize: getFontSize(
          13,
        ),
      );
  // Display text style
  static get displaySmallPrimary => theme.textTheme.displaySmall!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get displaySmallPrimaryRegular =>
      theme.textTheme.displaySmall!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w400,
      );
  // Headline text style
  static get headlineSmallBlack900 => theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.black900,
      );
  static get headlineSmallBluegray600 =>
      theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.blueGray600,
        fontWeight: FontWeight.w700,
      );
  static get headlineSmallBluegray600_1 =>
      theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.blueGray600,
      );
  static get headlineSmallBold => theme.textTheme.headlineSmall!.copyWith(
        fontWeight: FontWeight.w700,
      );
  static get headlineSmallPrimary => theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w700,
      );
  static get headlineSmallPrimary1 => theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w700,
      );
  // Label text style
  static get labelLarge12 => theme.textTheme.labelLarge!.copyWith(
        fontSize: getFontSize(
          12,
        ),
      );
  static get labelLargeBlack900 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.black900,
      );
  static get labelLargeBlack90012 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.black900,
        fontSize: getFontSize(
          12,
        ),
      );
  static get labelLargeBluegray600 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blueGray600,
        fontSize: getFontSize(
          12,
        ),
      );
  static get labelLargeGray500 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray500,
        fontSize: getFontSize(
          12,
        ),
      );
  static get labelLargeOnPrimary => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        fontSize: getFontSize(
          12,
        ),
      );
  static get labelLargeRed600 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.red600,
      );
  static get labelMediumErrorContainer => theme.textTheme.labelMedium!.copyWith(
        color: theme.colorScheme.errorContainer,
        fontSize: getFontSize(
          10,
        ),
      );
  // Title text style
  static get titleMediumBlack900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontSize: getFontSize(
          16,
        ),
      );
  static get titleMediumErrorContainer => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.errorContainer,
        fontSize: getFontSize(
          16,
        ),
      );
  static get titleMediumOnPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );
  static get titleSmallBluegray600 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray600,
      );
  static get titleSmallBluegray700 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray700,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallErrorContainer => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.errorContainer,
      );
  static get titleSmallGreen500 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.green500,
      );
  static get titleSmallPrimary => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w500,
      );
}

extension on TextStyle {
  TextStyle get quicksand {
    return copyWith(
      fontFamily: 'Quicksand',
    );
  }
}
