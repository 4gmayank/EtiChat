import 'dart:ui';

import 'package:flutter/material.dart';

class Constants {
  static final String user_detail = "user_details";
  static final RegExp emailRegExp = RegExp(
      r'^(([^<>()\[\]\\.,;:\s@\"]+(\.[^<>()\[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
}

class AppColors {
  static const Color textColor = Color(0xff080849);
  static const Color textColor2 = Color(0xff1B5299);
  static const Color appDark = Color(0xff1A4B92);
  static const Color appLight = Color(0xff207FC3);
  static const Color appColor = Color(0xff207FC3);
  static const Color white = Color(0xffffffff);
  static const Color whiteText = Color(0xffffffff);
  static const Color backgroundWhite = Color(0xffffffff);
  static const Color backgroundLight = Color(0xFFFDFBFB);
  static const Color backgroundDark = Color(0xFFEBEDEE);
  static const Color textBlack = Color(0xFF000000);
  static const Color black = Color(0xFF000000);
  static const Color greyOut = Color(0xFFEFEFEF);
  static const Color hintTextLight = Color(0x80000000); //textLight
  static const Color textExtraLight = Color(0xFF888888);
  static const Color border = Color(0xFFE5E5E5);
  static const Color divider = Color(0xFFC4C4C4);
}

class AppDecoration {
  static const Decoration screenDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColors.backgroundLight,
        AppColors.backgroundDark,
      ],
    ),
  );
}

class FontConstants {
  static const String FONT_HEADLINE = "Poppins";
}

class AppFonts {
  static TextStyle appBarBoldStyle(
      {double letterSpacing = 0,
      double height = 1.5,
      double lineHeight = 22.5,
      double fontSize = 15.0,
      Color fontColor = AppColors.textBlack,
      String fontFamily = FontConstants.FONT_HEADLINE,
      FontWeight fontWeight = FontWeight.w500,
      bool isUnderline = false}) {
    return _normalFontStyle(
      letterSpacing: letterSpacing,
      height: height,
      fontSize: fontSize,
      fontColor: fontColor,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static TextStyle headlineBoldStyle(
      {double letterSpacing = 0,
      double height = 1,
      double fontSize = 14.0,
      Color fontColor = AppColors.textBlack,
      String fontFamily = FontConstants.FONT_HEADLINE,
      FontWeight fontWeight = FontWeight.w600,
      bool isUnderline = false}) {
    return _normalFontStyle(
      letterSpacing: letterSpacing,
      height: height,
      fontSize: fontSize,
      fontColor: fontColor,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static TextStyle boldStyle(
      {double letterSpacing = 0,
      double height = 1,
      double fontSize = 12.0,
      Color fontColor = AppColors.textBlack,
      String fontFamily = FontConstants.FONT_HEADLINE,
      FontWeight fontWeight = FontWeight.w600,
      bool isUnderline = false}) {
    return _normalFontStyle(
      letterSpacing: letterSpacing,
      height: height,
      fontSize: fontSize,
      fontColor: fontColor,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static TextStyle normalStyle(
      {double letterSpacing = 0,
      double height = 1,
      double fontSize = 12.0,
      Color fontColor = AppColors.textBlack,
      FontStyle fontStyle = FontStyle.normal,
      String fontFamily = FontConstants.FONT_HEADLINE,
      FontWeight fontWeight = FontWeight.w500,
      bool isUnderline = false}) {
    return _normalFontStyle(
      letterSpacing: letterSpacing,
      height: height,
      fontSize: fontSize,
      fontColor: fontColor,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static TextStyle semiBoldStyle(
      {double letterSpacing = 0,
      double height = 1,
      double fontSize = 12.0,
      Color fontColor = AppColors.textBlack,
      FontStyle fontStyle = FontStyle.normal,
      String fontFamily = FontConstants.FONT_HEADLINE,
      FontWeight fontWeight = FontWeight.w500,
      bool isUnderline = false}) {
    return _normalFontStyle(
      letterSpacing: letterSpacing,
      height: height,
      fontSize: fontSize,
      fontColor: fontColor,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static TextStyle lightStyle(
      {double letterSpacing = 1,
      double height = 1,
      double fontSize = 10.0,
      Color fontColor = AppColors.textBlack,
      FontStyle fontStyle = FontStyle.normal,
      String fontFamily = FontConstants.FONT_HEADLINE,
      FontWeight fontWeight = FontWeight.w400,
      bool isUnderline = false}) {
    return _normalFontStyle(
      letterSpacing: letterSpacing,
      height: height,
      fontSize: fontSize,
      fontColor: fontColor,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static TextStyle _normalFontStyle(
      {double fontSize = 12.0,
      double height = 1,
      double lineHeight = 12.0,
      double letterSpacing = 0,
      Color fontColor = Colors.white,
      FontWeight fontWeight = FontWeight.normal,
      FontStyle fontStyle = FontStyle.normal,
      String fontFamily = FontConstants.FONT_HEADLINE,
      TextDecoration decoration = TextDecoration.none}) {
    return TextStyle(
      // height: lineHeight / fontSize >= 1.0 ? lineHeight / fontSize : height,
      letterSpacing: letterSpacing,
      fontFamily: fontFamily,
      color: fontColor,
      fontStyle: fontStyle,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: decoration,
    );
  }

  static TextStyle _headlineFontStyle(
      {double fontSize = 12.0,
      double letterSpacing = 1,
      double height = 1,
      Color fontColor = Colors.white,
      FontWeight fontWeight = FontWeight.normal,
      TextDecoration decoration = TextDecoration.none,
      Color backgroundColor = Colors.transparent}) {
    final Paint paint = Paint();
    paint.color = backgroundColor;
    return TextStyle(
        letterSpacing: letterSpacing,
        height: height,
        // fontFamily: FontConstants.FONT_HEADLINE,
        color: fontColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
        background: paint);
  }
}
