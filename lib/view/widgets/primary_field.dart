import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_app/constants/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PrimaryField extends StatelessWidget {
  PrimaryField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.isPasswordField,
    required this.prefixIcon,
    this.sufixIcon,
    this.isObscure,
    this.onTap,
    this.validator,
  }) : super(key: key);

  final String hintText;
  final IconData prefixIcon;
  final bool isPasswordField;
  bool? isObscure = false;
  final IconData? sufixIcon;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      validator: validator,
      controller: controller,
      obscureText: isPasswordField,
      cursorColor: primaryColor,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: sufixIcon != null
            ? GestureDetector(
                onTap: onTap,
                child: Icon(sufixIcon, color: lightGrey, size: Adaptive.px(15)))
            : null,
        prefixIcon: Icon(
          prefixIcon,
          color: lightGrey,
          size: Adaptive.px(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
          //<-- SEE HERE
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
          //<-- SEE HERE
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
          //<-- SEE HERE
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
          //<-- SEE HERE
        ),
      ),
    );
  }
}
