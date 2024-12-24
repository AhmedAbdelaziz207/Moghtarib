import 'package:flutter/material.dart';
import 'package:mo3tarib/core/theme/colors.dart';

class CustomTextFormField extends StatefulWidget {
  final IconData? prefixIcon;
  final String hintText;
  final TextStyle? hintStyle;
  final bool obscureText;
  final double borderRadius;
  final Color fillColor;
  final Color iconColor;
  final EdgeInsetsGeometry contentPadding;
  final TextEditingController? controller;

  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    this.prefixIcon,
    required this.hintText,
    this.hintStyle,
    this.obscureText = false,
    this.borderRadius = 12.0,
    this.fillColor = Colors.white,
    this.iconColor = Colors.grey,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
    this.controller,
    this.validator,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'هذا الحقل مطلوب';
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(widget.prefixIcon, color: primaryColor),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        filled: true,
        fillColor: widget.fillColor,
        contentPadding: widget.contentPadding,
        // Minimize height here
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide.none,
        ),
      ),
      obscureText: widget.obscureText,
    );
  }
}
