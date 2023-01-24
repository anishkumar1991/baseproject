import 'package:flutter/material.dart';
import 'package:sangathan/Values/app_colors.dart';

TextStyle textStyleWithPoppin({Color? color,double? fontSize,FontWeight? fontWeight}){
  return TextStyle(
    color: color ?? AppColor.naturalBlackColor,
    fontSize: fontSize ?? 18,
    fontFamily: 'Poppins',
    fontWeight: fontWeight ?? FontWeight.w400,
  );
}