import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text, int second) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: second),
      content: Text(
        text,
      ),
    ),
  );
}
