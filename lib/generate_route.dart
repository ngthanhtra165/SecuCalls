import 'package:flutter/material.dart';
import 'package:secucalls/screen/forget_password/forget_password_screen.dart';
import 'package:secucalls/screen/login/login_screen.dart';
import 'package:secucalls/screen/register/register_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/Login":
      return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen());
    case "/Register":
      return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => const RegisterScreen());
    case "/ForgetPassword":
      return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => const ForgetPasswordScreen());
    default:
      return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen());
  }
}