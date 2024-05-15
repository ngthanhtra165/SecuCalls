// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secucalls/common/button.dart';
import 'package:secucalls/common/text_field.dart';
import 'package:secucalls/constant/design_size.dart';
import 'package:secucalls/constant/style.dart';
import 'package:secucalls/screen/forget_password/forget_password_def.dart';
import 'package:secucalls/service/api_service.dart';
import 'package:secucalls/service/hive.dart';
import 'package:secucalls/utils/overlay_manager.dart';
import 'package:secucalls/utils/common_function.dart';
import 'package:secucalls/utils/token.dart';
import 'package:secucalls/utils/validate.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void tapOnRegisterButton() {
    log('move to register');
    FocusScope.of(context).unfocus();
    Navigator.of(context).pushNamed('/Register');
  }

  void tapOnSubmitButton() async {
    log('move to forget password');
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      _formKey.currentState?.save();

      // wait server response
      try {
        final password = passwordController.text;
        final confirmPassword = confirmPasswordController.text;
        final otpToken = await getString("otp_token", "otp_token") ?? "";

        if (isTokenExpired(otpToken)) {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed('/OTPValidation');
          showSnackBar(context, text_token_expired, 5);
          final email = await getString("email", "email") ?? "";
          await APIService.shared.forgetPassword(email);
          return;
        }

        OverlayIndicatorManager.show(context);
        await Future.delayed(const Duration(seconds: 1), () async {
          await APIService.shared.setPassword(
            otpToken,
            password,
            confirmPassword,
          );
          await clearBox("token_otp");
          await clearBox("email");
          OverlayIndicatorManager.hide();
          Navigator.pushNamedAndRemoveUntil(
              context, '/Login', (route) => false);
          showSnackBar(context, text_change_password_success, 2);
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
          // You can design your splash screen UI here
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text(
              title_appbar,
              textAlign: TextAlign.center,
              style: textBlack21Italic,
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: top_margin_title_text.h,
              ),
              const TextTitle(),
              SizedBox(
                height: top_margin_form_new_password.h,
              ),
              CustomForm(
                onPressed: tapOnSubmitButton,
                formKey: _formKey,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
              ),
              SizedBox(
                height: top_margin_register_button_new_password.h,
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

class CustomForm extends StatefulWidget {
  const CustomForm({
    super.key,
    required this.onPressed,
    required this.formKey,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final VoidCallback onPressed;
  final GlobalKey<FormState> formKey;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: EdgeInsets.only(
          left: left_margin_form.w,
          right: left_margin_form.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomTextField(
              icon: null,
              hintText: hint_text_new_password,
              controller: widget.passwordController,
              validator: (text) => validatePassword(text),
              isPassword: true,
            ),
            SizedBox(
              height: space_between_form_button.h,
            ),
            CustomTextField(
              icon: null,
              hintText: text_title_new_password,
              controller: widget.confirmPasswordController,
              validator: (text) =>
                  validateSimilarPassword(text, widget.passwordController.text),
              isPassword: true,
            ),
            SizedBox(
              height: space_between_form_button.h,
            ),
            CustomButton(
              text: text_button,
              onPressed: widget.onPressed,
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
          text_title_new_password,
          style: textGray21Italic,
        ),
      ),
    );
  }
}
