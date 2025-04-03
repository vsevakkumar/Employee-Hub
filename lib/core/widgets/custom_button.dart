import 'package:employee_hub/core/base/base/screen/base_screen.dart';
import 'package:employee_hub/core/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends BaseScreen {
  final String text;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final double? width;
  final Color? textColor;
  final BorderRadiusGeometry? borderRadius;

  CustomButton({
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
    this.width,
    this.textColor,
    this.borderRadius,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends BaseScreenState<CustomButton> {
  @override
  Widget body(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: widget.width != null ? screenUtil.setWidth(widget.width!) : null,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: widget.borderRadius ?? BorderRadius.circular(6.0),
        ),
        alignment: Alignment.center,
        // Center the text
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenUtil.setHeight(12),
            horizontal: screenUtil.setWidth(15),
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: widget.textColor ?? AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
