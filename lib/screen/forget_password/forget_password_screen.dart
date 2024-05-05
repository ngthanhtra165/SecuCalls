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

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void tapOnBackButton() {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop();
  }

  void tapOnRegisterButton() {
    log('move to register');
    FocusScope.of(context).unfocus();
    Navigator.of(context).pushNamed('/Register');
  }

  void tapOnForgetPasswordButton() async {
    log('move to forget password');
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState?.validate();

    if (isValid == true) {
      _formKey.currentState?.save();

      // wait server response
      try {
        final email = emailController.text;
        OverlayIndicatorManager.show(context);
        await Future.delayed(const Duration(seconds: 1), () async {
          await APIService.shared.forgetPassword(email);
          await addStringIntoBox("email", {"email": email});
          OverlayIndicatorManager.hide();

          Navigator.of(context).pushNamed('/OTPValidation');
        });
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
                height: top_margin_form.h,
              ),
              CustomForm(
                controller: emailController,
                onPressed: tapOnForgetPasswordButton,
                formKey: _formKey,
              ),
              SizedBox(
                height: top_margin_register_button.h,
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
              ),
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

  final VoidCallback onPressed;
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
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
              icon: Icons.alternate_email,
              hintText: hint_text_email,
              validator: (text) => validateEmail(text),
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
      child: const FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text_title,
          style: textGray21Italic,
        ),
      ),
    );
  }
}
