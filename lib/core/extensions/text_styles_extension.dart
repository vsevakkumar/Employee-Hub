import 'package:employee_hub/core/app_constants.dart';
import 'package:employee_hub/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension TextStylesExtension on String {
  Text getText18W500Text(
          {required ScreenUtil screenUtil,
          int maxLine = 1,
          TextAlign textAlign = TextAlign.start,
          TextDecoration? textDecoration}) =>
      Text(
        this,
        style: TextStyle(
          fontFamily: ROBOTO_FONT_FONT_FAMILY,
          fontSize: screenUtil.setSp(18.0),
          color: AppColors.blackTextColor,
          fontWeight: FontWeight.w500,
          decoration: textDecoration,
        ),
        textAlign: textAlign,
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,
      );

  Text getText16W400(
          {required ScreenUtil screenUtil,
          int maxLine = 1,
          TextAlign textAlign = TextAlign.start,
          TextDecoration? textDecoration}) =>
      Text(
        this,
        style: TextStyle(
          fontFamily: ROBOTO_FONT_FONT_FAMILY,
          fontSize: screenUtil.setSp(16.0),
          color: AppColors.blackTextColor,
          fontWeight: FontWeight.w400,
          decoration: textDecoration,
        ),
        textAlign: textAlign,
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,
      );

  Text getPrimaryText16W500(
      {required ScreenUtil screenUtil,
        int maxLine = 1,
        TextAlign textAlign = TextAlign.start,
        TextDecoration? textDecoration}) =>
      Text(
        this,
        style: TextStyle(
          fontFamily: ROBOTO_FONT_FONT_FAMILY,
          fontSize: screenUtil.setSp(16.0),
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w500,
          decoration: textDecoration,
        ),
        textAlign: textAlign,
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,
      );

  Text getDesc14W400(
      {required ScreenUtil screenUtil,
        int maxLine = 1,
        TextAlign textAlign = TextAlign.start,
        TextDecoration? textDecoration}) =>
      Text(
        this,
        style: TextStyle(
          fontFamily: ROBOTO_FONT_FONT_FAMILY,
          fontSize: screenUtil.setSp(14.0),
          color: AppColors.hintText,
          fontWeight: FontWeight.w400,
          decoration: textDecoration,
        ),
        textAlign: textAlign,
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,
      );

  Text getWhiteText16W400(
      {required ScreenUtil screenUtil,
        int maxLine = 1,
        TextAlign textAlign = TextAlign.start,
        TextDecoration? textDecoration}) =>
      Text(
        this,
        style: TextStyle(
          fontFamily: ROBOTO_FONT_FONT_FAMILY,
          fontSize: screenUtil.setSp(16.0),
          color: AppColors.whiteColor,
          fontWeight: FontWeight.w400,
          decoration: textDecoration,
        ),
        textAlign: textAlign,
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,
      );
}

TextStyle getText16W400TextStyle({
  required ScreenUtil screenUtil,

}) =>
    TextStyle(
      fontSize: screenUtil.setSp(16.0),
      color: AppColors.blackTextColor,
      fontWeight: FontWeight.w400,
    );
TextStyle getHintText16W400({
  required ScreenUtil screenUtil,

}) =>
    TextStyle(
      fontSize: screenUtil.setSp(16.0),
      color: AppColors.hintText,
      fontWeight: FontWeight.w400,
    );

