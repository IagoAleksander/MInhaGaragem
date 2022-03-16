import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData getThemeData() {
  return ThemeData(
      backgroundColor: ColorsRes.backgroundOffWhite,
      scaffoldBackgroundColor: ColorsRes.backgroundOffWhite,
      primaryColor: ColorsRes.primaryCyan,
      primaryColorDark: ColorsRes.primaryDarkViolet,
      cardColor: ColorsRes.backgroundWhite,
      indicatorColor: ColorsRes.neutralGray,
      errorColor: ColorsRes.secondaryRed,
      textTheme: const TextTheme(
        headline6: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 35,
          height: 1.3,
          color: ColorsRes.neutralGrayishViolet,
        ),
        subtitle1: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: ColorsRes.neutralGrayishViolet,
        ),
        bodyText1: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 17,
          height: 1.3,
          color: ColorsRes.neutralGrayishViolet,
        ),
        caption: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17,
            color: ColorsRes.neutralLightGray),
      ),
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: ColorsRes.primaryCyan));
}
