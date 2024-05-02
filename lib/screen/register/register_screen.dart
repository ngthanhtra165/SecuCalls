import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secucalls/common/appbar.dart';
import 'package:secucalls/common/button.dart';
import 'package:secucalls/common/text_field.dart';
import 'package:secucalls/constant/design_size.dart';
import 'package:secucalls/screen/register/register_screen_def.dart';
import 'package:secucalls/service/api_service.dart';
import 'package:secucalls/service/hive.dart';
import 'package:secucalls/service/overlay_manager.dart';
import 'package:secucalls/utils/validate.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void tapOnBackButton() {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop();
  }

  void tapOnRegisterButton() async {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState?.validate();

    if (isValid == true) {
      final firstName = firstNameController.text;
      final lastName = lastNameController.text;
      final email = emailController.text;
      final phone = phoneController.text;
      final password = passwordController.text;

      OverlayIndicatorManager.show(context);
      try {
        await Future.delayed(const Duration(seconds: 1), () async {
          final response = await APIService.shared
              .registerUser(firstName, lastName, email, phone, password);
          OverlayIndicatorManager.hide();
          Navigator.pushNamedAndRemoveUntil(
              context, '/Login', (route) => false);
        });
      } catch (e) {
        OverlayIndicatorManager.hide();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    }
  }

  void tapOnForgetPasswordButton() {
    log('move to forget password');
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
          appBar: CustomAppBar(
            icon: Icons.arrow_back_ios_rounded,
            title: title_appbar,
            onPressed: tapOnBackButton,
          ),
          body: SizedBox(
            height: screenHeight - keyboardHeight,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomForm(
                    onPressed: tapOnRegisterButton,
                    form: _formKey,
                    firstNameController: firstNameController,
                    lastNameController: lastNameController,
                    emailController: emailController,
                    passwordController: passwordController,
                    phoneController: phoneController,
                  ),
                  SizedBox(
                    height: top_margin_forget_password_button.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: left_margin_forget_password_button.w,
                      right: left_margin_forget_password_button.w,
                    ),
                    child: CustomTextButton(
                        text: text_button_forget_password,
                        onPressed: tapOnForgetPasswordButton,
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
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
    required this.form,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.phoneController,
  });

  final GlobalKey<FormState> form;
  final VoidCallback onPressed;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: left_margin_form.w, right: left_margin_form.w),
      child: Form(
        key: form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: top_margin_form.h,
            ),
            CustomTextField(
              controller: lastNameController,
              icon: Icons.account_box_outlined,
              hintText: hint_text_last_name,
              validator: (text) => validateName(text),
            ),
            SizedBox(
              height: space_between_text_fields.h,
            ),
            CustomTextField(
              controller: firstNameController,
              icon: Icons.account_box_outlined,
              hintText: hint_text_first_name,
              validator: (text) => validateName(text),
            ),
            SizedBox(
              height: space_between_text_fields.h,
            ),
            CustomTextField(
              controller: emailController,
              icon: Icons.alternate_email,
              hintText: hint_text_email,
              validator: (text) => validateEmail(text),
            ),
            SizedBox(
              height: space_between_text_fields.h,
            ),
            CustomTextField(
              controller: phoneController,
              icon: Icons.phone,
              hintText: hint_text_phone,
              validator: (text) => validatePhoneNumber(text),
            ),
            SizedBox(
              height: space_between_text_fields.h,
            ),
            CustomTextField(
              controller: passwordController,
              icon: Icons.lock_outline,
              hintText: hint_text_password,
              validator: (text) => validatePassword(text),
              isPassword: true,
            ),
            SizedBox(
              height: space_between_text_fields.h,
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
