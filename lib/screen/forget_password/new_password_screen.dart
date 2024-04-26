import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secucalls/common/appbar.dart';
import 'package:secucalls/common/button.dart';
import 'package:secucalls/common/text_field.dart';
import 'package:secucalls/constant/design_size.dart';
import 'package:secucalls/constant/style.dart';
import 'package:secucalls/screen/forget_password/forget_password_def.dart';
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

  void tapOnBackButton() {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop();
  }

  void tapOnRegisterButton() {
    log('move to register');
    Navigator.of(context).pushNamed('/Register');
  }

  void tapOnNewPasswordButton() {
    log('move to forget password');
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      _formKey.currentState?.save();

      // wait server response
      try {
        final password = passwordController.text;
        final confirmPassword = confirmPasswordController.text;
        final otp = 
        // final response = await APIService.shared.forgetPassword(email);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
      //Navigator.of(context).pushNamed('/');
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
                height: top_margin_form_new_password.h,
              ),
              CustomForm(
                onPressed: tapOnNewPasswordButton,
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
