import 'package:employee_hub/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;

  const CommonAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(

      backgroundColor: AppColors.primaryColor,
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
            color: AppColors.whiteColor),
      ),
      centerTitle: false,
      leading: null,
      automaticallyImplyLeading: false,

      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
