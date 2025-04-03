import 'package:employee_hub/core/base/base/screen/base_screen.dart';
import 'package:employee_hub/core/colors/app_colors.dart';
import 'package:employee_hub/core/extensions/text_styles_extension.dart';
import 'package:flutter/material.dart';

class CustomTextField extends BaseScreen {
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final GestureTapCallback? onTap;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    required this.controller,
    this.hintText = '',
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.validator,
    this.onChanged,
    this.onTap,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends BaseScreenState<CustomTextField> {
  @override
  Widget body(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      validator: widget.validator,
      style: getText16W400TextStyle(
        screenUtil: screenUtil,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        border: InputBorder.none,
        hintStyle: getHintText16W400(
          screenUtil: screenUtil,
        ),
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(
          borderColor: AppColors.primaryColor,
        ),
        errorBorder: outlineInputBorder(),
        disabledBorder: outlineInputBorder(),
        focusedErrorBorder: outlineInputBorder(),
        fillColor: widget.enabled ? Colors.white : Colors.grey[300],
        filled: true,
      ),
    );
  }

  OutlineInputBorder? outlineInputBorder({
    Color? borderColor,
  }) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(4),
        ),
        borderSide: BorderSide(
          color: borderColor ?? AppColors.dividerColor,
          width: screenUtil.setWidth(1.5),
        ),
      );
}
