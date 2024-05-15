import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secucalls/constant/constants.dart';
import 'package:secucalls/constant/style.dart';

// Custom TextField widget
class CustomTextField extends StatefulWidget {
  final IconData? icon;
  final String hintText;
  final String? Function(String?) validator;
  final Function(String?)? onSaved;
  final bool? isPassword;
  final bool? isOnlyDigits;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.icon,
    required this.hintText,
    required this.validator,
    this.isPassword,
    this.onSaved,
    this.isOnlyDigits,
    this.controller,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size_text_field_and_button.width.w,
      height: size_text_field_and_button.height.h,
      child: TextFormField(
        controller: widget.controller,
        keyboardType:
            (widget.isOnlyDigits != null) ? TextInputType.number : null,
        obscureText: (widget.isPassword != null) ? passwordVisible : false,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          errorStyle: const TextStyle(fontSize: 10.5),
          prefixIcon: (widget.icon == null)
              ? null
              : Icon(
                  widget.icon,
                  color: Colors.grey,
                  size: 40.w,
                ),
          suffixIcon: (widget.isPassword != null)
              ? IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        passwordVisible = !passwordVisible;
                      },
                    );
                  },
                )
              : null,
          hintText: widget.hintText,
          hintStyle: textGray19Italic,
          border: const OutlineInputBorder(),
          counterText: ' ',
        ),
        validator: widget.validator,
        onSaved: (newValue) {
          if (widget.onSaved != null) {
            widget.onSaved!(newValue);
          }
        },
      ),
    );
  }
}
