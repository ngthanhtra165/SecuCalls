// ignore_for_file: use_build_context_synchronously, unused_local_variable, library_private_types_in_public_api, avoid_print

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secucalls/common/button.dart';
import 'package:secucalls/common/text_field.dart';
import 'package:secucalls/constant/constants.dart';
import 'package:secucalls/constant/design_size.dart';
import 'package:secucalls/constant/style.dart';
import 'package:secucalls/screen/login/login_screen_def.dart';
import 'package:secucalls/service/api_service.dart';
import 'package:secucalls/service/hive.dart';
import 'package:secucalls/utils/flutter_background_service_utils.dart';
import 'package:secucalls/utils/overlay_manager.dart';
import 'package:secucalls/utils/common_function.dart';
import 'package:secucalls/utils/data_call.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //static const platform = MethodChannel('samples.flutter.dev/battery');
  @override
  void initState() {
    super.initState();
    requestPermission();
    //_initMonitoringIncomingCall();
    //updatePhoneContacts();
  }

  void tapOnLoginButton() async {
    FocusScope.of(context).unfocus();
    final phone = phoneController.text;
    final pass = passwordController.text;
    log('Name: $phone, Email: $pass');
    OverlayIndicatorManager.show(context);
    await Future.delayed(const Duration(seconds: 1), () async {
      try {
        final response = await APIService.shared.loginUser(phone, pass);
        await addStringIntoBox("token", {
          "access_token": response["access_token"],
          "refresh_token": response["refresh_token"],
        });
        await fetchDataFromServer(context);
        Navigator.of(context).pushNamed('/Dashboard');
        OverlayIndicatorManager.hide();
      } catch (e) {
        OverlayIndicatorManager.hide();
        passwordController.clear();
        showSnackBar(context, e.toString(), 4);
      }
    });
  }

  void tapOnRegisterButton() async {
    log('move to register');
    print("show pop up incoming");
    await FlutterOverlayWindow.showOverlay(
      enableDrag: true,
      overlayTitle: "X-SLAYER",
      overlayContent: 'Overlay Enabled',
      flag: OverlayFlag.defaultFlag,
    );
    // Navigator.of(context).pushNamed('/Register');
  }

  void tapOnForgetPasswordButton() async {
    log('move to register');
    Navigator.of(context).pushNamed('/ForgetPassword');
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return ScreenUtilInit(
      designSize: fullScreenPortraitSize,
      child: SafeArea(
        child: Scaffold(
          // You can design your splash screen UI here
          resizeToAvoidBottomInset: false,
          body: SizedBox(
            height: screenHeight - keyboardHeight,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: top_margin_logo.h,
                  ),
                  const LogoAndCompanyName(),
                  SizedBox(
                    height: top_margin_form.h,
                  ),
                  CustomForm(
                    phoneController: phoneController,
                    passwordController: passwordController,
                    onTapButton: tapOnLoginButton,
                  ),
                  RegisterAndForgetPasswordButtons(
                    tapOnRegisterButton: tapOnRegisterButton,
                    tapOnForgetPasswordButton: tapOnForgetPasswordButton,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterAndForgetPasswordButtons extends StatelessWidget {
  const RegisterAndForgetPasswordButtons({
    super.key,
    required this.tapOnRegisterButton,
    required this.tapOnForgetPasswordButton,
  });

  final VoidCallback tapOnRegisterButton;
  final VoidCallback tapOnForgetPasswordButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: left_margin_form.w,
        top: top_margin_two_buttons.h,
        right: left_margin_form.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextButton(
            text: text_register_button,
            onPressed: tapOnRegisterButton,
            textAlign: TextAlign.left,
          ),
          CustomTextButton(
              text: text_forget_password,
              onPressed: tapOnForgetPasswordButton,
              textAlign: TextAlign.right)
        ],
      ),
    );
  }
}

class LogoAndCompanyName extends StatelessWidget {
  const LogoAndCompanyName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size_logo.height.h,
      padding: EdgeInsets.only(
        left: left_margin_logo.w,
        right: left_margin_logo.w,
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset(
              "lib/assets/logo.png",
              width: size_logo.width.w,
              height: size_logo.height.h,
            ),
          ),
          Positioned(
            top: 415.h,
            left: 124.w,
            right: 124.w,
            child: const FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                name_company,
                textAlign: TextAlign.center,
                style: textBlack22Italic,
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Custom form widget containing multiple CustomTextField widgets
class CustomForm extends StatelessWidget {
  const CustomForm({
    super.key,
    required this.onTapButton,
    required this.phoneController,
    required this.passwordController,
  });

  final VoidCallback onTapButton;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: left_margin_form.w,
        right: left_margin_form.w,
      ),
      child: Column(
        children: [
          CustomTextField(
            controller: phoneController,
            icon: Icons.phone,
            hintText: text_phone,
            validator: (text) {
              if (text == null || text.trim() == "") {
                return "Empty phone!";
              }
              return null;
            },
          ),
          SizedBox(
            height: space_between_text_field.h,
          ),
          CustomTextField(
            controller: passwordController,
            icon: Icons.lock_outline,
            hintText: text_password,
            validator: (text) {
              if (text == null || text.trim() == "") {
                return "Empty password!";
              }
              return null;
            },
            isPassword: true,
          ),
          SizedBox(
            height: space_between_text_field.h,
          ),
          CustomButton(
            text: text_button,
            onPressed: onTapButton,
          ),
        ],
      ),
    );
  }
}
