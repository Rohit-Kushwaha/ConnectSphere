import 'package:career_sphere/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.hintText,
      this.suffixIcon,
      this.obscureText = false});

  final TextEditingController controller;
  final String labelText, hintText;
  final Widget? suffixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.black),
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 10.w),
          suffixIcon: suffixIcon,
          labelText: labelText,
          hintText: hintText,
          labelStyle: merienda16(context),
          hintStyle: merienda14(context)),
    );
  }
}
