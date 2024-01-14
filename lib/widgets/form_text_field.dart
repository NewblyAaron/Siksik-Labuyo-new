import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormTextField extends StatelessWidget {
  const FormTextField({
    super.key,
    required this.controller,
    this.validator,
    this.label,
    this.icon,
    this.obscureText,
    this.inputFormatters,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onEditingComplete
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? label;
  final IconData? icon;
  final bool? obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String?)? onChanged;
  final VoidCallback? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText ?? false,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: label,
        icon: Icon(icon),
      ),
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
    );
  }
}
