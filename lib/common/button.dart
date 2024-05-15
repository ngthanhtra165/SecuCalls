import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secucalls/constant/constants.dart';
import 'package:secucalls/constant/style.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size_text_button.width.w,
      height: size_text_button.height.h ,
      child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color(0xFF266CBF),
            ), // Set the background color
            side: MaterialStateProperty.all<BorderSide>(
              const BorderSide(color: Colors.grey),
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0), // Set border radius
              ),
            ), // Set the border color
          ),
          onPressed: onPressed,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: textWhite19Italic,
          )),
    );
  }
}


class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final TextAlign textAlign;
  const CustomTextButton({super.key, 
    required this.text,
    required this.onPressed, required this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0), // Set borderRadius to 0 for no border
          ),
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          textAlign: textAlign,
          style: textGray19Italic, // Set text color
        ),
      ),
    );
  }
}
