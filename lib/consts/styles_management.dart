import 'package:flutter/material.dart';
import 'package:tuncecom/consts/fonts_management.dart';

TextStyle _getTextStyle({
  required double fontSize,
  required String fontFamily,
  required Color color,
  required FontWeight fontWeight,
}) {
  return TextStyle(
    fontWeight: fontWeight,
    color: color,
    fontSize: fontSize,
    fontFamily: fontFamily,
  );
}

//Regular Style
TextStyle getRegularStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize: fontSize,
      fontFamily: FontConstants.montserrat,
      color: color,
      fontWeight: FontWeightManager.regular);
}

//Light Style
TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize: fontSize,
      fontFamily: FontConstants.montserrat,
      color: color,
      fontWeight: FontWeightManager.light);
}

//Medium Style
TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize: fontSize,
      fontFamily: FontConstants.montserrat,
      color: color,
      fontWeight: FontWeightManager.medium);
}

//SemiBold Style
TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize: fontSize,
      fontFamily: FontConstants.montserrat,
      color: color,
      fontWeight: FontWeightManager.semiBold);
}

//Bold Style
TextStyle getBoldStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize: fontSize,
      fontFamily: FontConstants.montserrat,
      color: color,
      fontWeight: FontWeightManager.bold);
}
