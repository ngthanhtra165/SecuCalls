// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:secucalls/service/api_service.dart';
import 'package:secucalls/service/hive.dart';
import 'package:secucalls/utils/common_function.dart';

class DrawerUtils {
  static void tapOnChangePasswordButton(
      BuildContext context, GlobalKey<ScaffoldState> _scaffoldKey) {
    Navigator.of(context).pushNamed('/ChangePassword');
    _scaffoldKey.currentState?.openEndDrawer();
  }

  static void tapOnLogOutButton(BuildContext context) async {
    log('move to log out');
    try {
      await APIService.shared.logoutUser();
      clearBox("token");
      clearBox("otp_token");
      Navigator.pushNamedAndRemoveUntil(context, '/Login', (route) => false);
    } catch (e) {
      showSnackBar(context, e.toString(), 4);
    }
  }

  static void tapOnHomeButton(
      BuildContext context, GlobalKey<ScaffoldState> _scaffoldKey) {
    log('move Dashboard');
    Navigator.of(context).pushNamed('/Dashboard');
    _scaffoldKey.currentState?.openEndDrawer();
  }

  static void tapOnCallLogButton(
      BuildContext context, GlobalKey<ScaffoldState> _scaffoldKey) {
    log('move to call log');
    Navigator.of(context).pushNamed('/CallLog');
    _scaffoldKey.currentState?.openEndDrawer();
  }

  static void tapOnSameButton(GlobalKey<ScaffoldState> _scaffoldKey) {
    _scaffoldKey.currentState?.openEndDrawer();
  }
}
