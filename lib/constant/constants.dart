// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const Size size_logo = Size(500, 500);
const Size size_text_field_and_button = Size(640, 160);
const Size size_text_button = Size(640, 120);

const String requirement_password = """
Password must be 8-16 characters long, contain at least 1 lowercase letter, 1 uppercase letter, 1 digit, and 1 special character from the list ( !, @, #, \$ , %, ^, &, *)""";

enum TypeOfCall {
  outgoing,
  incoming,
  missed,
}
