// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:secucalls/screen/call_log/Call_Log_Screen.dart';
import 'package:secucalls/screen/dashboard/dashboard_screen.dart';
import 'package:secucalls/screen/forget_password/forget_password_screen.dart';
import 'package:secucalls/screen/forget_password/new_password_screen.dart';
import 'package:secucalls/screen/forget_password/otp_validatiton_screen.dart';
import 'package:secucalls/screen/login/login_screen.dart';
import 'package:secucalls/screen/register/register_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/Login":
      return _createRoute(const LoginScreen());
    case "/Register":
      return _createRoute(const RegisterScreen());
    case "/ForgetPassword":
      return _createRoute(const ForgetPasswordScreen());
    case "/Dashboard":
      return _createRoute(const DashboardScreen());
    case "/OTPValidation":
      return _createRoute(const OTPValidationScreen());
    case "/NewPassword":
      return _createRoute(const NewPasswordScreen());
          case "/CallLog":
      return _createRoute(CallLogScreen());
    default:
      return _createRoute(const LoginScreen());
  }
}

Route _createRoute(Widget toScreen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => toScreen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
