import 'package:flutter/material.dart';
import 'package:this_is_project/components/colors/app_colors.dart';
import 'package:this_is_project/components/dimens/app_dimens.dart';

class AuthForm extends StatelessWidget {
  final String label;
  final void Function(String)? onChanged;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const AuthForm({
    required this.label,
    required this.onChanged,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.prymaryTextColor,
      validator: validator,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        label: Text(
          label,
          style: const TextStyle(color: AppColors.prymaryTextColor),
        ),
        enabledBorder: _getBorderDecoration(AppColors.textFormFieldBorderColor),
        focusedBorder: _getBorderDecoration(AppColors.textFormFieldFocusedBorderColor),
      ),
    );
  }

  OutlineInputBorder _getBorderDecoration(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimens.sm),
      borderSide: BorderSide(
        color: color,
        width: AppDimens.xxs,
      ),
    );
  }
}
