import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  final String label;
  final void Function(String)? onChanged;
  final TextStyle? style;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const AuthForm({
    required this.label,
    required this.onChanged,
    this.style,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        label: Text(
          label,
          style: style,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
