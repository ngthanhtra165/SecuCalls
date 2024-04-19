import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secucalls/constant/constants.dart';
import 'package:secucalls/constant/style.dart';

// Custom TextField widget
class CustomTextField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.icon,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size_text_field_and_button.width.w,
      height: size_text_field_and_button.height.h,
      child: TextFormField(
        textAlign: TextAlign.left,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.grey,
            size: 40.w,
          ),
          hintText: hintText,
          hintStyle: textGray19Italic,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
