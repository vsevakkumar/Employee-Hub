import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ImageExtensions on String{
  Image getImage({
    required ScreenUtil screenUtil,
    Color? imgColor,
    double? height,
    double? width,
    BoxFit? boxFit,
    double? scale,
  }) =>
      Image.asset(
        this,
        height: height != null ? screenUtil.setHeight(height) : null,
        width: width != null ? screenUtil.setWidth(width) : null,
        color: imgColor,
        fit: boxFit,
        scale: scale,
      );
}