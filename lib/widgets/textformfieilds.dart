// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final Color? borderColor;
  final double borderWidth;
  final double borderRadius;
  final TextInputType? keyBoardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final double? height;
  final int? maxlenghth;

  const CustomTextFormField(
      {super.key,
      required this.controller,
      this.hintText,
      this.labelText,
      required this.borderColor,
      this.borderWidth = 2.0,
      this.borderRadius = 8.0,
      this.keyBoardType,
      this.obscureText = false,
      this.suffixIcon,
      this.validator,
      this.height,
      this.maxlenghth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: SizedBox(
        height: height,
        child: TextFormField(
          keyboardType: keyBoardType,
          obscureText: obscureText,
          validator: validator,
          maxLength: maxlenghth,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: borderColor!,
                width: borderWidth,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: borderColor!,
                width: borderWidth,
              ),
            ),
          ),
          controller: controller,
        ),
      ),
    );
  }
}
