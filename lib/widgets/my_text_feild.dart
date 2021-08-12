import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyTextField extends StatelessWidget {
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final bool isPassword;
  final String hintText;

  const MyTextField({
    Key? key,
    required this.onChanged,
    required this.onSubmitted,
    this.focusNode,
    required this.textInputAction,
    required this.isPassword,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: TextField(
        obscureText: isPassword,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        focusNode: focusNode,
        style: TextStyle(
            fontSize: 18.sp,
            color: Colors.black87,
            fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
          border: InputBorder.none,
        ),
        textInputAction: textInputAction,
      ),
    );
  }
}
