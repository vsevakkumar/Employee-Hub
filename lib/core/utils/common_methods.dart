import 'package:employee_hub/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> navigatePush(BuildContext context, Widget route,
    {bool? fullscreenDialog}) async {
  return await Navigator.push(
    context,
    MaterialPageRoute(
        builder: (BuildContext context) => route,
        fullscreenDialog:
            ((fullscreenDialog == null) ? false : fullscreenDialog)),
  );
}

goBack(BuildContext context, {String? route, dynamic result}) {
  Navigator.pop(context, result);
}

Future<T?> showCommonBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  bool isScrollable = false,
  required ScreenUtil screenUtil,
}) async =>
    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(4.0),
        ),
      ),
      isScrollControlled: isScrollable,
      builder: (_) => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(
                0,
                screenUtil.setHeight(5.0),
              ),
              color: AppColors.blackTextColor.withOpacity(0.1),
              blurRadius: 5.0,
            ),
          ],
        ),
        child: child,
      ),
    );

Future<T?> showAppDialog<T>({
  required BuildContext context,
  Color? color,
  required ScreenUtil screenUtil,
  required Widget child,
  bool barrierDismissible = true,
  Color? barrierColor,
  Color? surfaceTintColor,
}) async =>
    await showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      barrierColor: barrierColor ?? AppColors.blackTextColor.withOpacity(0.50),
      builder: (BuildContext context) => Dialog(
        elevation: 0,
        insetPadding: EdgeInsets.symmetric(
          horizontal: screenUtil.setWidth(22.0),
          vertical: screenUtil.setHeight(16.0),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: color ?? AppColors.whiteColor,
            boxShadow: [
              BoxShadow(
                offset: Offset(
                  0,
                  screenUtil.setHeight(10.0),
                ),
                color: AppColors.blackTextColor.withOpacity(0.1),
                blurRadius: 24.0,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
