// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secucalls/common/appbar.dart';
import 'package:secucalls/common/button.dart';
import 'package:secucalls/common/text_field.dart';
import 'package:secucalls/constant/design_size.dart';
import 'package:secucalls/constant/style.dart';
import 'package:secucalls/screen/forget_password/forget_password_def.dart';
import 'package:secucalls/service/api_service.dart';
import 'package:secucalls/service/hive.dart';
import 'package:secucalls/utils/overlay_manager.dart';
import 'package:secucalls/utils/common_function.dart';
import 'package:secucalls/utils/validate.dart';

class OTPValidationScreen extends StatefulWidget {
  const OTPValidationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OTPValidationScreenState createState() => _OTPValidationScreenState();
}

class _OTPValidationScreenState extends State<OTPValidationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  void tapOnBackButton() {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop();
    //Navigator.of(context).pushReplacementNamed('/ForgetPassword');
  }

  void tapOnRegisterButton() {
    print('move to register');
    FocusScope.of(context).unfocus();
    Navigator.of(context).pushNamed('/Register');
  }

  void tapOnOTPValidationButton() async {
    log('move to forget password');
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      // wait server response
      try {
        final otp = otpController.text;
        OverlayIndicatorManager.show(context);

        await Future.delayed(
          const Duration(seconds: 1),
          () async {
            final response = await APIService.shared.otpValidation(otp);
            OverlayIndicatorManager.hide();
            await addStringIntoBox("otp_token", {
              "otp_token": response["otp_token"],
            });
            Navigator.of(context).pushNamed('/NewPassword');
            showSnackBar(context, text_otp_validate_success, 2);
          },
        );
      } catch (e) {
        OverlayIndicatorManager.hide();
        showSnackBar(context, e.toString(), 4);
      }

      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: fullScreenPortraitSize,
      child: SafeArea(
        child: Scaffold(
          // You can design your splash screen UI here
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
            icon: Icons.arrow_back_ios_rounded,
            title: title_appbar,
            onPressed: tapOnBackButton,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: top_margin_title_text.h,
              ),
              const TextTitle(),
              SizedBox(
                height: top_margin_form_otp.h,
              ),
              CustomForm(
                controller: otpController,
                onPressed: tapOnOTPValidationButton,
                formKey: _formKey,
              ),
              SizedBox(
                height: 80.h,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: left_margin_register_button.w,
                  right: left_margin_register_button.w,
                ),
                child: CustomTextButton(
                  text: text_register_button,
                  onPressed: tapOnRegisterButton,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomForm extends StatelessWidget {
  const CustomForm({
    super.key,
    required this.onPressed,
    required this.formKey,
    required this.controller,
  });

  final TextEditingController controller;
  final VoidCallback onPressed;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.only(
          left: left_margin_form.w,
          right: left_margin_form.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomTextField(
              controller: controller,
              icon: null,
              hintText: hint_text_otp,
              validator: (text) => validateOTP(text),
              isOnlyDigits: true,
            ),
            SizedBox(
              height: space_between_form_button.h,
            ),
            CustomButton(
              text: text_button,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}

class TextTitle extends StatelessWidget {
  const TextTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: left_margin_title_text.w,
        right: left_margin_title_text.w,
      ),
      child: const Text(
        text_title_otp_validation,
        style: textGray21Italic,
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
    );
  }
}
